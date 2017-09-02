defmodule IoHandler do
   @moduledoc """
  Reads and writes packets using the Language Server Protocol's wire protocol
  """
  alias Sorcery.IOHandler.PacketStream

  @spec start_link(atom()):: {:ok | :error, pid()}
  def start_link(handler, opts \\ []) do
    pid = Process.spawn(__MODULE__, :read_stdin, [handler], [:link])
    if opts[:name], do: Process.register(pid, opts[:name])
    {:ok, pid}
  end

  # Handler is the genserver that will process the packets
  @spec read_stdin(atom()):: :ok
  def read_stdin(handler) do
    PacketStream.stream(Process.group_leader)
    |> Stream.each(fn packet -> handler.receive_packet(packet) end)
    |> Stream.run
  end

  @spec send(%{}) :: :ok
  def send(packet) do
    body = Poison.encode!(packet) <> "\r\n\r\n"
    IO.binwrite("Content-Length: #{byte_size(body)}\r\n\r\n" <> body)
  end
end
