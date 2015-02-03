defmodule Preview.Mixfile do
  use Mix.Project

  @application_list [:phoenix, :cowboy, :logger, :postgrex, :ecto, :comeonin, :mailgun, :csvlixir]

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
     applications: app_list(Mix.env)]
  end

  defp app_list(:test) do
    [:hound] ++ @application_list
  end
  defp app_list(_) do
    @application_list
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix,  "~> 0.8.0"},
      {:cowboy,   "~> 1.0"},
      {:postgrex, "~> 0.6.0"},
      {:ecto,     "~> 0.6.0"},
      {:comeonin, "~> 0.2.2"},
      {:mailgun,  "~> 0.0.1"},
      {:csvlixir,  "~> 1.0.0"},
      {:hound,    "~> 0.6.0", only: :test}
    ]
  end
end
