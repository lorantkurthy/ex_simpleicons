defmodule Simpleicons.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :ex_simpleicons,
      version: @version,
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      description: description(),
      package: package(),
      source_url: "https://github.com/lorantkurthy/ex_simpleicons"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:phoenix_live_view, "~> 0.20 or ~> 1.0"},
      {:ex_doc, "~> 0.35", only: :dev, runtime: false},
      {:floki, ">= 0.36.0", only: :test},
      {:simpleicons,
       github: "simple-icons/simple-icons",
       tag: "14.14.0",
       sparse: "icons",
       app: false,
       compile: false,
       depth: 1,
       only: :test}
    ]
  end

  defp docs do
    [
      main: "Simpleicons",
      source_ref: "v#{@version}",
      source_url: "https://github.com/lorantkurthy/ex_simpleicons",
      extras: ["README.md"]
    ]
  end

  defp description() do
    """
    This package adds a convenient way of using Simpleicons with your Phoenix, Phoenix LiveView and Surface applications.
    """
  end

  defp package do
    %{
      files: ~w(lib .formatter.exs mix.exs README* LICENSE* CHANGELOG*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/lorantkurthy/ex_simpleicons"}
    }
  end
end
