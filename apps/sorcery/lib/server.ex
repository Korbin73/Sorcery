defmodule Sorcery.Server do
  use GenServer
  require Logger

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end
  
  def receive_packet(server, packet) do
    GenServer.call(server, {:recieve_packet, packet})
  end

  def handle_call({:recieve_packet, _packet}, _from, state) do
    IO.puts "[Info] Recieved packet."
    {:reply, :not_implemented, state}
  end
end