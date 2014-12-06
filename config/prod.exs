use Mix.Config

# ## SSL Support
#
# To get SSL working, you will need to set:
#
#     https: [port: 443,
#             keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#             certfile: System.get_env("SOME_APP_SSL_CERT_PATH")]
#
# Where those two env variables point to a file on
# disk for the key and cert.

config :phoenix, Preview.Router,
  url: [host: "example.com"],
  http: [port: System.get_env("PORT")],
  secret_key_base: "TFrRTVbErmZJ+7AAlrt8PVhBLsc93Bxmk+JnNyz17j0BFvZNRHuIth5xAtHZxVfBUwhXKdxjGRk3tS7DYml3og=="

config :logger,
  level: :info

config :preview,
  postgres_pass: System.get_env("POSTGRES_PASS"),
  mailgun_domain: "my_mailgun_domain",
  mailgun_key: System.get_env("MAILGUN_KEY")
