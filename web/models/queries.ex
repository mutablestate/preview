defmodule Preview.Queries do
  import Ecto.Query
  alias Preview.Repo
  alias Preview.Authenticate
  alias Preview.Signup
  alias Preview.User

  @doc """
  Query for all users
  Returns list of structs
  """
  def all_users do
    query = from user in User,
            select: user

    Repo.all(query)
  end

  @doc """
  Query finds user by email
  Returns user struct or nil
  """
  def find_by_email(email) do
    query = from user in User,
            where: user.email == ^email,
            select: user

    Repo.one(query)
  end

  @doc """
  Query for all signups
  Returns list of structs
  """
  def all_signups do
    query = from signup in Signup,
            select: signup

    Repo.all(query)
  end

  @doc """
  Query authenticates user
  Returns user struct or nil
  """
  def login(email, password) do
    query = from user in User,
            where: user.email == ^email,
            select: user

    user = Repo.one(query)

    _login(user, password)
  end

  defp _login(nil, _) do
    Comeonin.Bcrypt.dummy_checkpw
    nil
  end
  defp _login(user, password), do: Authenticate.password(user, password)
end
