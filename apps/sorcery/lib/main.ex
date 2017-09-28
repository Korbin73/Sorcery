defmodule Sorcery.Main do
  use Application

  def start(_type, _args) do
    Supervisor.start_link([{Sorcery.Server, []}], strategy: :one_for_one)
  end

  def stop(_state) do
    :init.stop
  end
end