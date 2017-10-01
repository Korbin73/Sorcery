defmodule Sorcery.Server do
  use GenServer

  require Logger

  def start_link() do
    GenServer.start_link __MODULE__, %{}, name: __MODULE__
  end

  def receive_packet(server, packet) do
    Sorcery.JsonRpc.log_message :info,
                                "[Info] Packet received.",
                                &Sorcery.JsonRpc.send/1
    GenServer.call server, {:recieve_packet, packet}
  end

  def handle_call({:recieve_packet, _packet}, _from, state) do
    IO.puts "[Info] Recieved packet."
    # P{:reply, :not_implemented, state}
    {:ok, %{"capabilities" => server_capabilities()}, state}
  end

  def server_capabilities do
    %{
      "textDocumentSync" => 1,
      "hoverProvider" => true,
      "completionProvider" => %{},
      "definitionProvider" => true,
    }
  end
end
