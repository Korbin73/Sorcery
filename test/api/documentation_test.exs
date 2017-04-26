defmodule Sorcery.API.Documentation do
   use ExUnit.Case, async: true

  alias Sorcery.API.Docl

  test "DOCL full request" do
    docl_resp = Docl.request(~s({ "defmodule", [ context: Elixir, imports: [], aliases: [] ] }))
    assert docl_resp =~ """
    Defines a module given by name with the given contents.
    """
    assert docl_resp =~ ~r"END-OF-DOCL$"
  end

  test "DOCL request" do
    assert Docl.process(['defmodule', [], []]) =~ """
    Defines a module given by name with the given contents.
    """
  end

  test "DOCL request with no match" do
    assert Docl.process(['FooBar', [], []]) =~ "Could not load module FooBar"
  end

  test "DOCL request for List.flatten" do
    assert Docl.process(["List.flatten", [], []])  =~ "Flattens the given " 
  end

  test "DOCL request for MyCustomList.flatten with alias" do
    assert Docl.process(["MyCustomList.flatten", [], [{MyCustomList, List}]]) =~ "Flattens the given "
  end

  test "DOCL request for search create_file with import" do
    assert Docl.process(["create_file", [Mix.Generator], []]) =~ "Creates a file with the given contents."  
  end

  test "DOCL request for defmacro" do
    assert Docl.process(["defmacro", [], []]) =~ "defmacro defmacro(call, expr \\\\ nil)"
  end

  test "DOCL request for Path.basename/1" do
    assert Docl.process(["Path.basename/1", [], []]) =~ "Returns the last component of the path or the path"   
  end
end