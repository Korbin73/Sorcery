defmodule SorceryTest do
  use ExUnit.Case
  # doctest Sorcery   

  test "Should start server genserver" do
    GenServer.start_link(Sorcery.Server, %{})
  end
end
