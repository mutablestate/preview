use Mix.Config

config :preview, Preview.Endpoint,
  http: [port: System.get_env("PORT") || 4000],
  debug_errors: true

# Enables code reloading for development
config :phoenix, :code_reloader, true

config :preview,
  postgres_pass:  System.get_env("POSTGRES_PASS"),
  mailgun_domain: System.get_env("MAILGUN_DOMAIN"),
  mailgun_key:    System.get_env("MAILGUN_KEY")
