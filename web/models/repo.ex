defmodule Preview.Repo do
  use Ecto.Repo,
    otp_app: :preview,
    adapter: Ecto.Adapters.Postgres
end
