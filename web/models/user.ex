defmodule Preview.User do
  use Preview.Web, :model

  alias Preview.User
  alias Preview.Repo
  alias Preview.Authenticate

  schema "users" do
    field :email,    :string
    field :password, :string

    timestamps
  end

  @required_fields ~w(email password)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_unique(:email, on: Repo)
  end

  @doc """
  Checks an email is stored in the db before
  authenticating the user with the password

  Returns {:ok, message} or {:error, message} tuple
  """
  def letmein(email, password) do
    user =
      User
      |> select([user], user)
      |> where([user], user.email == ^email)
      |> Repo.one

    _letmein(user, password)
  end

  defp _letmein(nil, _) do
    Comeonin.Bcrypt.dummy_checkpw
    {:error, "Please enter a valid email and password"}
  end
  defp _letmein(user, password), do: Authenticate.password(user, password)
end
