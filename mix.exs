defmodule Preview.Mixfile do
  use Mix.Project

  def project do
    [app: :preview,
     version: "0.1.0",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Preview, []},
     applications: [:phoenix, :cowboy, :logger, :ecto,
                    :postgrex, :comeonin, :mailgun, :csvlixir]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "~> 1.0"},
     {:phoenix_ecto, "~> 0.8"},
     {:phoenix_html, "~> 2.0"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:postgrex, ">= 0.0.0"},
     {:cowboy, "~> 1.0"},
     {:comeonin, "~> 1.1"},
     {:mailgun, "~> 0.1"},
     {:csvlixir, "~> 2.0.0"}]
  end
end
