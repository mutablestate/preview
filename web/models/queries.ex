defmodule Preview.Queries do
  import Ecto.Query
  alias Preview.Authenticate

  @doc """
  Query for all users

  Returns list of structs
  """
  def all_users do
    query = from user in Preview.User,
            select: user

    Preview.Repo.all(query)
  end

  @doc """
  Query finds user by username

  Returns user struct or nil
  """
  def find_by_username(username) do
    query = from user in Preview.User,
            where: user.username == ^username,
            select: user

    Preview.Repo.one(query)
  end

  @doc """
  Query for all signups

  Returns list of structs
  """
  def all_signups do
    query = from signup in Preview.Signup,
            select: signup

    Preview.Repo.all(query)
  end

  @doc """
  Query authenticates user

  Returns user struct or nil
  """
  def login(username, password) do
    query = from user in Preview.User,
            where: user.username == ^username,
            select: user

    user = Preview.Repo.one(query)

    _login(user, password)
  end
  defp _login(nil, _) do
    Comeonin.Bcrypt.dummy_checkpw
    nil
  end
  defp _login(user, password), do: Authenticate.password(user, password)
end
