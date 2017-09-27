defmodule SorceryTest do
  use ExUnit.Case
  # doctest Sorcery   

  setup do
    {:ok, proc} = GenServer.start_link(Sorcery.Server, %{})
    %{server: proc }
  end
  
  test "Should start server genserver", %{server: server} do
    GenServer.call(server, {:recieve_packet, %{"movie"=>"x-men"}})
  end

  test "this should call the genserver" do
    
  end
end
