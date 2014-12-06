# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the router
config :phoenix, Preview.Router,
  url: [host: "localhost"],
  http: [port: System.get_env("PORT")],
  secret_key_base: "TFrRTVbErmZJ+7AAlrt8PVhBLsc93Bxmk+JnNyz17j0BFvZNRHuIth5xAtHZxVfBUwhXKdxjGRk3tS7DYml3og==",
  catch_errors: true,
  debug_errors: false,
  error_controller: Preview.PageController

# Session configuration
config :phoenix, Preview.Router,
  session: [store: :cookie,
            key: "_preview_key"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
