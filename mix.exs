defmodule OpenApiSpexYaml.MixProject do
  use Mix.Project

  @source_url "https://github.com/starfish-codes/open_api_spex_yaml"
  @version "3.11.0"

  def project do
    [
      app: :open_api_spex_yaml,
      version: @version,
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package() do
    [
      name: "open_api_spex_yaml",
      description: "Mix task with YAML formatter for open_api_spec library",
      files: [
        "lib",
        "mix.exs",
        "README.md",
        "LICENSE",
        ".formatter.exs"
      ],
      maintainers: [
        "Starfish Team",
      ],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url
      }
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:jason, "~> 1.0", only: [:dev, :test]},
      {:open_api_spex, "~> 3.0"},
      {:ymlr, "~> 2.0"}
    ]
  end

  defp docs do
    [
      extras: [
        {:LICENSE, [title: "License"]},
        "README.md"
      ],
      main: "readme",
      homepage_url: @source_url,
      source_url: @source_url,
      source_ref: "v#{@version}",
      formatters: ["html"]
    ]
  end
end
