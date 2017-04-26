defmodule Sorcery.API.CompletTest do
  use ExUnit.Case, async: true

  alias Sorcery.API.Comp
  import ExUnit.CaptureIO

  test "completion with an empty hint" do
    assert capture_io(fn ->
      Comp.process([nil,[], [List],[], [],[]])
    end) =~ """
    import/2;function
    """
  end

  test "COMP request without empty hint" do
    assert capture_io(fn ->
      Comp.process(['is_b', [], [],[], [], []])
    end) =~ """
    is_b
    is_binary/1;module
    is_bitstring/1;module
    is_boolean/1;module
    END-OF-COMP
    """
  end

  test "COMP request with a module hint" do
    assert capture_io(fn ->
      Comp.process(['Str', [], [], [], [], []])
    end) =~ """
    Stream;module
    String;module
    StringIO;module
    """
  end

  test "COMP request with no match" do
    assert capture_io(fn ->
      Comp.process(['Fouthoo', [], [], [], [], []])
    end) =~ """
    END-OF-COMP
    """
  end
end
