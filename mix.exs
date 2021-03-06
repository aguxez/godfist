defmodule Godfist.Mixfile do
  @moduledoc false

  use Mix.Project

  def project do
    [
      app: :godfist,
      version: "0.5.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.html": :test],
      description: description(),
      package: pkg(),
      deps: deps()
    ]
  end

  defp description do
    """
    Wrapper for the League of Legends ReST API written in Elixir.
    """
  end

  defp pkg do
    [
      maintainers: ["Miguel Diaz"],
      licenses: ["MIT"],
      files: ["lib", "priv", "mix.exs", "README.md", "LICENSE*", "config/config.exs"],
      links: %{"Github" => "https://github.com/aguxez/godfist"}
    ]
  end

  def application do
    [
      extra_applications: [:logger, :jason, :httpoison, :ex_rated, :cachex],
      mod: {Godfist.Application, []}
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:jason, "1.0.0"},
      {:ex_rated, "~> 1.3"},
      {:cachex, "~> 3.0"},
      {:pastry, github: "aguxez/pastry"},
      {:credo, "~> 0.9.0", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:excoveralls, "~> 0.6", only: :test},
      {:bypass, "~> 0.8", only: :test}
    ]
  end
end
