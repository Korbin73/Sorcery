defmodule Sorcery.CLI do
  require Logger

  def main(_args) do
    # Makes sure the process stays alive so that the genserver can recieve
    # incoming requests
    Logger.add_backend {LoggerFileBackend, :debug}
    Logger.configure_backend {LoggerFileBackend, :debug},
      path: "/Users/Lee1/Documents/Elixirist/language_server/debug.log"

    :timer.sleep(:infinity)
  end
end
