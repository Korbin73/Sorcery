defmodule IoHandlerTest do
  use ExUnit.Case
  doctest IoHandler

  test "greets the world" do
    assert IoHandler.hello() == :world
  end
end
