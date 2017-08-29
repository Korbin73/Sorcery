defmodule ElixirLS.LanguageServer.Server do
  use GenServer
  alias ElixirLS.LanguageServer.{Protocol, JsonRpc, Completion, Hover, Definition, Notifications}
  use Protocol

  ## Client API

  def start_link(name \\ nil) do    
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def receive_packet(server \\ __MODULE__, packet) do
    GenServer.call(server, {:receive_packet, packet})
  end

  ## Server Callbacks

  def init(:ok) do    
    {:ok}
  end

  def handle_call({:request_finished, id, {:error, type, msg}}, _from) do    
    
  end

  def handle_call({:request_finished, id, {:ok, result}}, _from) do    
    
  end

  def handle_call({:receive_packet, request(id, _, _) = packet}, _from) do 
    
  end

  def handle_call({:receive_packet, notification(_) = packet}, _from) do
    
  end

  def handle_info({:DOWN, ref, :process, _pid, :normal}, state) do
    
  end

  def handle_info({:DOWN, ref, :process, _pid, reason}, state) do
    
  end

  def handle_info(info, state) do
    super(info, state)
  end

  def handle_notification(notification("initialized"), state) do
    
  end

  def terminate(reason, state) do
    
  end

  ## Helpers

  defp find_and_update(list, find_fn, update_fn) do
    
  end

  defp handle_request_async(id, func) do
    
  end  

  defp send_responses(state) do
    
  end

  defp update_request(state, id, update_fn) do
    
  end

  defp update_request_by_ref(state, ref, update_fn) do
    
  end  
end
