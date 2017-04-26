defmodule Sorcery.API.Syms do
  alias Sorcery.Code.Parser
  alias Sorcery.API.Defs

  def query_workspace(:filter, query) do
    IO.inspect(query, label: "Typed in query")
  end

  def get_file_list({:ok, files}), do: files

  @spec add_path(%{}, String.t) :: %{}
  def add_path(token, dir), do: Map.put(token, :path, dir)

  @spec parse_single_file(String.t) :: %{}
  def parse_single_file(dir) do
    # Grab the function list of each file that comes through
    Parser.parse_file(dir, true, true, 0)
    |> Map.get(:mods_funs_to_lines)
    |> Enum.filter(fn token ->
        {{_module, _func_name, scope}, _line_number} = token
        scope != nil
       end)
    |> Enum.map(&Sorcery.API.Defs.jsonize_token/1)
    |> Sorcery.API.Defs.add_request_type()
    |> add_path(dir)
  end

  @spec parse_workspace(String.t) :: String.t
  def parse_workspace(dir) do
    elixir_files = Path.wildcard(dir <> "/**/*.{ex, exs}")
      |> Enum.reject(fn path -> Regex.match?(~r/\/deps\//, path) end)
      |> Stream.map(&Task.async(Sorcery.API.Syms, :parse_single_file, [&1]))
      |> Enum.map(&Task.await(&1))
      |> Poison.encode()
      |> Defs.extract_json()
  end
end
