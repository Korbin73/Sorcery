defmodule Sorcery.API.Defs do
  alias Sorcery.Code.Parser

  @type token_detail :: %{line: number, module: String.t, func_name: String.t}

  @spec jsonize_token({{String, :atom, any}, number}) :: token_detail
  def jsonize_token({{module, func_name, _}, line_number}) do
    %{line: line_number, module: module, func_name: Atom.to_string(func_name)}
  end

  def add_request_type(function_list) do
    %{request_type: 1, function_list: function_list}
  end

  def extract_json({:ok, json}), do: json
  def extract_json({:error, _}), do: "{}"

  # Returns a list of functions in a file with their line numbers
  @spec get_for_page(String.t) :: %{}
  def get_for_page(dir) do
    # grab the functions for the file at ths point
    Parser.parse_file(dir, true, true, 0)
    |> Map.get(:mods_funs_to_lines)
    |> Enum.filter(fn token ->
        {{_module, _func_name, scope}, _line_number} = token
        scope != nil
       end)
    |> Enum.map(&jsonize_token/1)
    |> add_request_type()
    |> Poison.encode()
    |> extract_json()
  end
end
