defmodule Sorcery.API.DefinitionTests do
   use ExUnit.Case

  alias Sorcery.API.Defl

  test "DEFL request call for defmodule" do
    context = [context: Elixir, imports: [], aliases: []]
    assert Defl.process([nil, :defmodule, context]) == {Kernel, nil}
  end

  test "DEFL request call for import" do
    context = [context: Elixir, imports: [], aliases: []]
    assert Defl.process([nil, :import, context]) == {Kernel.SpecialForms, nil}
  end

  test "DEFL request call for create_file with available import" do
    context = [context: Elixir, imports: [Mix.Generator], aliases: []]
    assert Defl.process([nil, :create_file, context]) == {Mix.Generator, nil}
  end

  test "DEFL request call for MyList.flatten with available aliases" do
    context = [context: Elixir, imports: [], aliases: [{MyList, List}]]
    assert Defl.process([MyList, :flatten, context]) == {List, nil}
  end

  test "DEFL request call for String module" do
    context = [context: Elixir, imports: [], aliases: []]
    assert Defl.process([String, nil, context]) == {String, nil}
  end

  test "DEFL request call for erlang module" do
    context = [ context: Elixir, imports: [], aliases: [] ]
    assert Defl.process([:lists, :duplicate, context]) == {:lists, "/usr/local/Cellar/erlang/19.2/lib/erlang/lib/stdlib-3.2/src/lists.erl"}
  end

  test "DEFL request call for none existing module" do
    context = [ context: Elixir, imports: [], aliases: [] ]
    assert Defl.process([Rock, :duplicate, context]) == {Rock, nil}
  end
end
