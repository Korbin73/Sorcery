defmodule Sorcery.Server do
  #@version "0.1.0-beta"

  @moduledoc """
  The Alchemist-Server operates as an informant for a specific desired
  Elixir Mix project and serves with informations as the following:

    * Completion for Modules and functions.
    * Documentation lookup for Modules and functions.
    * Code evaluation and quoted representation of code.
    * Definition lookup of code.
    * Listing of all available Mix tasks.
    * Listing of all available Modules with documentation.
  """

  alias Sorcery.Server.IO, as: ServerIO
  alias Sorcery.Server.Socket, as: ServerSocket

  def main(args) do
    {opts, _, _} = OptionParser.parse(args) 
    
    env = Keyword.get(opts, :env, "dev")
    noansi = Keyword.get(opts, :no_ansi, false)
    port = Keyword.get(opts, :port, 0)
    Application.put_env(:iex, :colors, [enabled: !noansi])

    case Keyword.get(opts, :listen, false) do
      false -> ServerIO.start([env: env])
      true -> ServerSocket.start([env: env, port: port])
    end
    :timer.sleep :infinity
  end
end
