defmodule Sorcery.Server.Socket do

  alias Sorcery.Helpers.ProcessCommands

  def start(opts) do
    import Supervisor.Spec

    IO.inspect("Socket started.")

    env  = Keyword.get(opts, :env)
    port = Keyword.get(opts, :port, 0)
    

    children = [
      supervisor(Task.Supervisor, [[name: Sorcery.Server.Socket.TaskSupervisor]]),
      worker(Task, [__MODULE__, :accept, [env, port]])
    ]

    opts = [strategy: :one_for_one, name: Sorcery.Server.Socket.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def accept(env, port) do
    {:ok, socket} = :gen_tcp.listen(Integer.parse(port) |> elem(0),
                    [:binary, packet: :line, active: false, reuseaddr: true])
    {:ok, port} = :inet.port(socket)
    IO.puts "ok|localhost:#{port}"
    loop_acceptor(socket, env)
  end

  defp loop_acceptor(socket, env) do
    {:ok, client} = :gen_tcp.accept(socket)
    {:ok, pid} = Task.Supervisor.start_child(Sorcery.Server.Socket.TaskSupervisor, fn -> serve(client, env) end)
    :ok = :gen_tcp.controlling_process(client, pid)
    loop_acceptor(socket, env)
  end

  defp serve(socket, env) do
    write_line(~s("{ "capabilities": { "hoverProvider": "false", "completionProvider": { "resolveProvider": "true" } } }"), socket)
    case read_line(socket) do
      :closed -> {:stop, :closed}
      data when is_binary(data) ->
        IO.inspect data
        data
        |> String.strip
        |> ProcessCommands.process(env)
        |> write_line(socket)

        serve(socket, env)
    end
  end

  defp read_line(socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} -> data
      {:error, :closed} -> :closed
    end
  end

  defp write_line(line, socket) do
    :gen_tcp.send(socket, line)
  end
end
