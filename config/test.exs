use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :preview, Preview.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :preview, Preview.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "preview_test",
  size: 1,
  max_overflow: false

# Configure mailgun
config :preview,
  mailgun_domain: System.get_env("MAILGUN_DOMAIN"),
  mailgun_key:    System.get_env("MAILGUN_KEY")
