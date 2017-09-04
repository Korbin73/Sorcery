defmodule Sorcery.Server do
  use GenServer
  require Logger
  
  def receive_packet(server, packet) do
    GenServer.call(server, {:recieve_packet, packet})
  end

  def handle_call({:recieve_packet, _packet}) do
    IO.puts "Handle call getting made."
    :not_implemented
  end
end