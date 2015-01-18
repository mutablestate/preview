use Mix.Config

config :preview, Preview.Endpoint,
  http: [port: System.get_env("PORT") || 4000],
  debug_errors: true,
  cache_static_lookup: false

# Enables code reloading for development
config :phoenix, :code_reloader, true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

config :preview,
  mailgun_domain: System.get_env("MAILGUN_DOMAIN"),
  mailgun_key:    System.get_env("MAILGUN_KEY")

# Config ecto repo
config :preview, Preview.Repo,
  database: "preview_dev",
  username: "deploy",
  password: "#{System.get_env("POSTGRES_PASS")}",
  hostname: "localhost"

