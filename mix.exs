defmodule DigiCoin.MixProject do
  use Mix.Project

  def project do
    [
      app: :digi_coin,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: releases(),
      elixirc_options: [warnings_as_errors: true],
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:idna, :logger],
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
      {:castore, "~> 0.1"},
      {:plug_cowboy, "~> 2.0"},
      {:ex_machina, "~> 2.7.0", only: :test}
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

  # This makes sure your factory and any other modules in test/support are compiled
  # when in the test environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
