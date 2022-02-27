defmodule DigiCoin.MixProject do
  use Mix.Project

  def project do
    [
      app: :digi_coin,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: releases(),
      elixirc_options: [warnings_as_errors: true]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {DigiCoin.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:idna, "~> 6.0"},
      {:tesla, "~> 1.4"},
      {:gun, "~> 1.3"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.0"}
    ]
  end

  # Releasing versions
  defp releases do
    [
      digi_coin: [
        include_executables_for: [:unix],
        applications: [runtime_tools: :permanent],
        path: "./releases"
      ]
    ]
  end
end
