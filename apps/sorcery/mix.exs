defmodule ElixirLS.LanguageServer.Mixfile do
  use Mix.Project

  def project do
    [app: :sorcery,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_path: "../../_build",
     config_path: "config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     build_embedded: false,
     start_permanent: true,
     build_per_environment: false,
     consolidate_protocols: false,
     deps: deps(),
     escript: escript()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [mod: {ElixirLS.LanguageServer, []}, applications: [:mix, :logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:io_handler, in_umbrella: true},
     {:elixir_sense, github: "msaraiva/elixir_sense"}]
  end

  defp escript do
    [main_module: ElixirLS.LanguageServer.CLI, 
     embed_elixir: true, 
     path: "../../release/sorcery",
     strip_beam: false, 
    ]
  end
end
