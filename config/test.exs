use Mix.Config

config :preview, Preview.Endpoint,
  http: [port: System.get_env("PORT") || 4001]

# Print only warnings and errors during test
config :logger, level: :warn

config :preview,
  mailgun_domain: System.get_env("MAILGUN_DOMAIN"),
  mailgun_key:    System.get_env("MAILGUN_KEY")

# Config ecto repo
config :preview, Preview.Repo,
  database: "preview_dev",
  username: "deploy",
  password: "#{System.get_env("POSTGRES_PASS")}",
  hostname: "localhost"

# Start Hound for PhantomJS
config :hound, driver: "phantomjs"


