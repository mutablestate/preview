defmodule Preview.Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres

  def conf do
    parse_url "ecto://deploy:#{config_postgres_pass}@localhost/preview_development"
  end

  def priv do
    app_dir(:preview, "priv/repo")
  end

  def config_postgres_pass do
    Application.get_env(:preview, :postgres_pass)
  end
end
