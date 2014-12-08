defmodule Preview.User do
  use Ecto.Model

  schema "users" do
    field :username, :string
    field :password, :string
    field :created_at, :datetime, default: Ecto.DateTime.local
    field :updated_at, :datetime, default: Ecto.DateTime.local
  end
end
