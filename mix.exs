defmodule Godfist.Mixfile do
  use Mix.Project

  def project do
    [app: :godfist,
     version: "0.1.1",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: pkg(),
     deps: deps()]
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
      links: %{"Github" => "https://github.com/aguxez/godfist"}
    ]
  end

  def application do
    [extra_applications: [:logger, :httpoison, :poison, :ex_rated]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.11.2"},
      {:poison, "~> 3.1"},
      {:ex_rated, "~> 1.3"},
      {:credo, "~> 0.7.4", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
