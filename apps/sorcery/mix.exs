defmodule Sorcery.Mixfile do
  use Mix.Project

  def project do
    [
      app: :sorcery,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Sorcery.Main, []},
      extra_applications: [:logger]
    ]
  end

  def escript() do
    [
      main_module: Sorcery.CLI,
      path: "../../release/sorcery"
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      # {:sibling_app_in_umbrella, in_umbrella: true},
      {:io_handler, in_umbrella: true}
    ]
  end
end
