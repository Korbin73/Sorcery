defmodule Sorcery.Code.File  do
  alias Sorcery.Code.Function.Detail

  def get_ast(source) do
    IO.inspect(source)
    case Code.string_to_quoted(source) do
      {:ok, ast} ->
        {:ok, ast}
      error ->
        {:error, "Could not get quoted expression."}
    end
  end

  defp pre_walk({def_name, [line: line], [{name, _, params}, _body]} = ast, state) when def_name in [:def, :defp] and is_atom(name) do
    parameter_list = for param <- params do
      case param do
        {param_name, _, _} -> Atom.to_string(param_name)
        _ -> to_string(param)
      end
    end
    current_function = [%Detail{name: Atom.to_string(name), line_number: line, parameters: parameter_list}]

    {ast, Enum.into(state, current_function)}
  end

  defp pre_walk(ast, current_node) do
    {ast, current_node}
  end

  defp post_walk(ast, current_node), do: {ast, current_node}

  def traverse_tree({:ok, ast}) do
    Macro.traverse(ast, [], &pre_walk/2, &post_walk/2)
  end

  @spec get_functions(%{}) :: %{}
  def get_functions(file) do
    case File.read(file) do
      {:ok, source} ->
        get_ast(source)
        |> traverse_tree()
      error -> error
    end
  end
end
