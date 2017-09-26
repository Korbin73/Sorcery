defmodule Sorcery.Server do
  use GenServer
  require Logger
  
  def receive_packet(server, packet) do
    GenServer.call(server, {:recieve_packet, packet})
  end

  def handle_call({:recieve_packet, _packet}, _from, state) do
    IO.puts "Handle call getting made."
    {:reply, :not_implemented, state}
  end
end