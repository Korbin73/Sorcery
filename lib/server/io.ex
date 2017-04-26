defmodule Sorcery.Server.IO do
  require Logger
  @moduledoc false

  use GenServer

  alias Sorcery.Helpers.ProcessCommands

  def start(opts) do
    env = Keyword.get(opts, :env)
    GenServer.start_link(__MODULE__,  env, [])
  end

  def init(env) do
    {:ok, env, 0}
  end

  def handle_info(:timeout, env) do 
    IO.puts ~s("Result: { "capabilities": { "textDocumentSync": 1 } }")
    Logger.debug "Should display."
    ProcessCommands.process(read_line(), env)
    |> IO.write
    {:noreply, env, 0} 
  end

  def read_line do
    IO.gets("") |> String.rstrip()
  end
end
