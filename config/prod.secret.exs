use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :preview, Preview.Endpoint,
  secret_key_base: "Wt6W9dET4zT3PT+cDV5NbF/LabL1g/K2Pk5VGog0oZa3XJ2FiYfPn2wIVm+iYCCU"

# Configure your database
config :preview, Preview.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "preview_prod"
