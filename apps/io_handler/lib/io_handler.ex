defmodule Sorcery.IOPreviousHandler do
  @moduledoc """
  Reads and writes packets using the Language Server Protocol's wire protocol
  """
  alias Sorcery.IOHandler.PacketStream

  def start_link(handler, opts \\ []) do
    IO.puts "IO Handler started."
    pid = Process.spawn(__MODULE__, :read_stdin, [handler], [:link])
    if opts[:name], do: Process.register(pid, opts[:name])
    {:ok, pid}
  end

  def read_stdin(handler) do
    PacketStream.stream(Process.group_leader)
    |> Stream.each(fn packet -> handler.receive_packet(packet) end)
    |> Stream.run
  end
end

defmodule Sorcery.IOCommunication do
  def send(packet) do
    body = Poison.encode!(packet) <> "\r\n\r\n"
    IO.binwrite("Content-Length: #{byte_size(body)}\r\n\r\n" <> body)
  end
end