defmodule Preview.Mixfile do
  use Mix.Project

  def project do
    [app: :preview,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Preview, []},
     applications: [:phoenix, :cowboy, :logger, :postgrex, :ecto, :mailgun]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "~> 0.7.2"},
      {:cowboy, "~> 1.0"},
      {:postgrex, "~> 0.6.0"},
      {:ecto, "~> 0.2.5"},
      {:mailgun, "~> 0.0.1"}
    ]
  end
end
