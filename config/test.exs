use Mix.Config

config :preview, Preview.Endpoint,
  http: [port: System.get_env("PORT") || 4001]

config :preview,
  postgres_pass: System.get_env("POSTGRES_PASS"),
  mailgun_domain: "my_mailgun_domain",
  mailgun_key: System.get_env("MAILGUN_KEY")
