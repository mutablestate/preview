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

config :preview, Preview.Endpoint,
  url: [host: "example.com"],
  http: [port: System.get_env("PORT")],
  secret_key_base: "Gkv+bJOMTQXRek5HUTU2dG/VwvGdfjl2wM2OZKJUSWAzNqF4P8vHVLim66ZwN2KF"

config :logger,
  level: :info

config :preview,
  postgres_pass:  System.get_env("POSTGRES_PASS"),
  mailgun_domain: System.get_env("MAILGUN_DOMAIN"),
  mailgun_key:    System.get_env("MAILGUN_KEY")
