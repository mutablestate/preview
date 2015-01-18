defmodule Preview.User do
  use Ecto.Model

  schema "users" do
    field :username, :string
    field :password, :string
    timestamps
  end
end
