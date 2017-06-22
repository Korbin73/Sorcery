defmodule ElixirLS.LanguageServer.Server do
  @moduledoc """
  Language Server Protocol server

  This server tracks open files, attempts to rebuild the project when a file changes, and handles
  requests from the IDE (for things like autocompletion, hover, etc.)

  Notifications from the IDE are handled synchronously, whereas requests can be handled sychronously
  or asynchronously. 
  
  When possible, handling the request asynchronously has several advantages. The asynchronous 
  request handling cannot modify the server state.  That way, if the process handling the request
  crashes, we can report that error to the client and continue knowing that the state is 
  uncorrupted. Also, asynchronous requests can be cancelled by the client if they're taking too long
  or the user no longer cares about the result. Regardless of completion order, the protocol
  specifies that requests must be replied to in the order they are received.
  """

  use GenServer
  alias ElixirLS.LanguageServer.{Protocol, JsonRpc, Completion, Hover, Definition}
  require Logger
  use Protocol

  defstruct [
    build_errors: %{},
    build_failures: 0,
    builder: nil,
    changed_sources: %{},
    client_capabilities: nil,
    currently_compiling: nil, 
    force_rebuild?: false,
    received_shutdown?: false, 
    requests: [],
    root_uri: nil,
    settings: nil,
    source_files: %{},
  ]

  defmodule Request do
    defstruct [:id, :status, :pid, :ref, :result, :error_type, :error_msg]
  end

  ## Client API

  def start_link(name \\ nil) do    
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def receive_packet(server \\ __MODULE__, packet) do    
    GenServer.call(server, {:receive_packet, packet})
  end

  ## Server Callbacks

  def init(:ok) do    
    {:ok, %__MODULE__{}}
  end

  def handle_call({:request_finished, id, {:error, type, msg}}, _from, state) do    
    state = update_request(state, id, &(%{&1 | status: :error, error_type: type, error_msg: msg}))
    {:reply, :ok, send_responses(state)}
  end

  def handle_call({:request_finished, id, {:ok, result}}, _from, state) do    
    state = update_request(state, id, &(%{&1 | status: :ok, result: result}))
    {:reply, :ok, send_responses(state)}
  end

  def handle_call({:receive_packet, request(id, _, _) = packet}, _from, state) do 
    Logger.info("Recieved handled.")    
    {request, state} = 
      case handle_request(packet, state) do
        {:ok, result, state} ->
          {%Request{id: id, status: :ok, result: result}, state}
        {:error, type, msg, state} ->
          {%Request{id: id, status: :error, error_type: type, error_msg: msg}, state}
        {:async, fun, state} ->
          {pid, ref} = handle_request_async(id, fun)
          {%Request{id: id, status: :async, pid: pid, ref: ref}, state}
      end

    state = %{state | requests: state.requests ++ [request]}    
    {:reply, :ok, send_responses(state)}
  end

  def handle_call({:receive_packet, notification(_) = packet}, _from, state) do
    {:reply, :ok, handle_notification(packet, state)}
  end

  def handle_info({:DOWN, ref, :process, _pid, :normal}, state) do
    state = 
      update_request_by_ref state, ref, fn
        %{status: :async} = req ->
          error_msg = "Internal error: Request ended without result"
          %{req | ref: nil, pid: nil, status: :error, error_type: :internal_error, 
                  error_msg: error_msg}
        req ->
          %{req | ref: nil, pid: nil}
      end

    {:noreply, send_responses(state)}
  end

  def handle_info({:DOWN, ref, :process, _pid, reason}, state) do
    state = 
      update_request_by_ref state, ref, fn
        %{status: :async} = req ->
          error_msg = "Internal error: " <> Exception.format_exit(reason)
          %{req | ref: nil, pid: nil, status: :error, error_type: :internal_error, 
                  error_msg: error_msg}
        req ->
          %{req | ref: nil, pid: nil}
      end

    {:noreply, send_responses(state)}
  end

  def handle_info(info, state) do
    super(info, state)
  end

  def terminate(reason, state) do
    unless reason == :normal do
      msg = "Elixir Language Server terminated abnormally because "
        <> Exception.format_exit(reason)
      JsonRpc.log_message(:error, msg)
    end
    super(reason, state)
  end

  ## Helpers

  defp find_and_update(list, find_fn, update_fn) do
    idx = Enum.find_index(list, find_fn)
    if idx do
      List.update_at(list, idx, update_fn)
    else
      list
    end
  end

  defp handle_notification(notification("initialized"), state) do
    Logger.info("Handle initialize with: #{inspect(state)}")
    state  # noop
  end

  defp handle_notification(notification("$/setTraceNotification"), state) do
    state  # noop
  end

  defp handle_notification(cancel_request(id), state) do
    state = 
      update_request state, id, fn
        %{status: :async, pid: pid} = req ->
          Process.exit(pid, :kill)
          %{req | pid: nil, ref: nil, status: :error, error_type: :request_cancelled}
        req ->
          req
      end

    send_responses(state)
  end

  defp handle_notification(did_change_configuration(settings), state) do
    %{state | settings: settings}
  end

  defp handle_notification(notification("exit"), state) do
    System.halt(0)
    state
  end

  defp handle_notification(did_open(_uri, _language_id, _version, _text), _state) do
    Logger.info("Handle notification did open.")    
  end

  defp handle_request(initialize_req(_id, root_uri, client_capabilities), state) do    
    state = %{state | root_uri: root_uri}

    state = %{state | client_capabilities: client_capabilities, root_uri: root_uri}

    {:ok, %{"capabilities" => server_capabilities()}, state}
  end

  defp handle_request(request(_id, "shutdown", _params), state) do
    {:ok, nil, %{state | received_shutdown?: true}}
  end

  defp handle_request(definition_req(_id, uri, line, character), state) do
    fun = fn ->
      {:ok, Definition.definition(state.source_files[uri].text, line, character)}
    end
    {:async, fun, state}
  end

  defp handle_request(hover_req(_id, uri, line, character), state) do
    fun = fn ->
      {:ok, Hover.hover(state.source_files[uri].text, line, character)}
    end
    {:async, fun, state}
  end

  defp handle_request(completion_req(_id, uri, line, character), state) do
    fun = fn ->
      {:ok, Completion.completion(state.source_files[uri].text, line, character)}
    end
    {:async, fun, state}
  end

  defp handle_request(request(_, _, _), state) do
    {:error, :invalid_request, nil, state}
  end

  defp handle_request_async(id, func) do
    parent = self()
    Process.spawn(fn ->
      result = func.()
      GenServer.call(parent, {:request_finished, id, result})
    end, [:monitor])
  end  

  defp send_responses(state) do
    case state.requests do
      [%Request{id: id, status: :ok, result: result} | rest] ->
        JsonRpc.respond(id, result)
        send_responses(%{state | requests: rest})
      [%Request{id: id, status: :error, error_type: error_type, error_msg: error_msg} | rest] ->
        JsonRpc.respond_with_error(id, error_type, error_msg)
        send_responses(%{state | requests: rest})
      _ ->
        state
    end
  end

  defp server_capabilities do
    %{"textDocumentSync" => 1,
      "hoverProvider" => true,
      "completionProvider" => %{},
      "definitionProvider" => true}
  end

  defp update_request(state, id, update_fn) do
    update_in state.requests, fn requests ->
      find_and_update(requests, &(&1.id == id), update_fn)
    end
  end

  defp update_request_by_ref(state, ref, update_fn) do
    update_in state.requests, fn requests ->
      find_and_update(requests, &(&1.ref == ref), update_fn)
    end
  end  
end
