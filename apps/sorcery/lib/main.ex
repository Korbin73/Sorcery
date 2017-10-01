defmodule Sorcery.Main do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    
    children = [
      worker(Sorcery.Server, []),
      worker(Sorcery.IOPreviousHandler, [Sorcery.Server]),
    ]

    opts = [strategy: :one_for_one, name: Sorcery.Supervisor, max_restarts: 0]
    Supervisor.start_link(children, opts)
  end

  def stop(_state) do
    :init.stop
  end
end