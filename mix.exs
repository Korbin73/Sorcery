defmodule LanguageServer.Mixfile do
  use Mix.Project
  
  def project do
    [apps_path: "apps",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      build_per_environment: false,
      deps: deps()]
  end
  
  defp deps do
    []
  end
end
