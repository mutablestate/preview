defmodule Preview.Signup do
  use Ecto.Model

  schema "signups" do
    field :email, :string
  end
end
