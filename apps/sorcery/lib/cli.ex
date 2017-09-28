defmodule Sorcery.CLI do
  def main(_args) do
    # Makes sure the process stays alive so that the genserver can recieve 
    # incoming requests
    IO.puts "[Info] Should not fall asleep"
    :timer.sleep(:infinity)
  end
end