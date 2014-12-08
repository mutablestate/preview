defmodule Preview.Signup do
  use Ecto.Model

  schema "signups" do
    field :email, :string
    field :created_at, :datetime, default: Ecto.DateTime.local
    field :updated_at, :datetime, default: Ecto.DateTime.local
  end
end
