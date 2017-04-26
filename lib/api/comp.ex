defmodule Sorcery.API.Comp do

  @moduledoc false

  alias Sorcery.Helpers.Complete
  alias Sorcery.Code.Metadata
  alias Sorcery.Code.Parser

  def request(args) do
    args
    |> normalize
    |> process
  end

  @spec append_token_type(List.t, Atom.t) :: List.t
  def append_token_type(token_list, token_type) do
    Enum.map token_list, fn current_token ->
      case token_type do
        :function when is_list(current_token) ->
          List.to_string(current_token) <> ";function"
        :function ->
          current_token <> ";function"
        :module when is_list(current_token) ->
          List.to_string(current_token) <> ";module"
        :module ->
          current_token <> ":module"
      end
    end
  end

  def process([nil, _, imports, _, _, _]) do
    {imports_token_list, import_token_type} = Complete.run('', imports)
    {token_list, token_type} = Complete.run('')

    with_imports    = append_token_type(imports_token_list, import_token_type)
    without_imports = append_token_type(token_list, token_type)

    with_imports ++ without_imports
    |> print
  end

  def process([hint, _context, imports, aliases, vars, attributes]) do
    Application.put_env(:"alchemist.el", :aliases, aliases)

    {list1, funcs } = Complete.run(hint, imports)
    {list2, token_type } = Complete.run(hint)
    first_item = Enum.at(list2, 0)

    # Remove this aweful rebinding statements. This was put here to appease the warning from the
    # compiler.
    {first_item, list2} =
      if first_item in [nil, ""] do
        {"#{hint};hint", list2}
      else
        {first_item, List.delete_at(list2, 0)}
      end

    function_list = Enum.map list2, fn function_name ->
        case token_type do
          :function -> List.to_string(function_name) <> ";function"
          :module -> List.to_string(function_name) <> ";module"
        end
    end

    full_list = [first_item] ++ find_attributes(attributes, hint) ++ find_vars(vars, hint) ++ list1 ++ function_list
    full_list |> print
  end

  defp normalize(request) do
    {{hint, buffer_file, line}, _} = request |> String.replace("\\", "/") |> Code.eval_string()

    context = Elixir

    metadata = Parser.parse_file(buffer_file, true, true, line) 

    %{imports: imports,
      aliases: aliases,
      vars: vars,
      attributes: attributes,
      module: module} = Metadata.get_env(metadata, line)

    [hint, context, [module|imports], aliases, vars, attributes]
  end

  defp print(result) do
    result
    |> Enum.uniq
    |> Enum.map(&IO.puts/1)

    IO.puts "END-OF-COMP"
  end

  defp find_vars(vars, hint) do
    for var <- vars, hint == "" or String.starts_with?("#{var}", hint) do
      "#{var};var"
    end
  end

  defp find_attributes(attributes, hint) do
    for attribute <- attributes, hint in ["", "@"] or String.starts_with?("@#{attribute}", hint) do
      "@#{attribute};attribute"
    end
  end
end
