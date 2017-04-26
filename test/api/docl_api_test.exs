defmodule DoclApiTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO

  alias Sorcery.API.Docl

  test "should get a response from the docl api" do
    capture_io(fn -> 
      send self(), Docl.process(['defmodule', [], []]) =~ "Defines a module given by name with the given contents."
    end)
    assert_received true
  end
end