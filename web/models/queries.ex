defmodule Preview.Queries do
  import Ecto.Query
  import Preview.Authenticate
  alias Preview.Authenticate

  def all_users do
    query = from user in Preview.User,
            select: user

    Preview.Repo.all(query)
  end

  def all_signups do
    query = from signup in Preview.Signup,
            select: signup

    Preview.Repo.all(query)
  end

  def login(username, password) do
    query = from user in Preview.User,
            where: user.username == ^username,
            select: user

    user = Preview.Repo.one(query)

    authenticate_password(user, password)
  end

  defp authenticate_password(nil, _),  do: nil
  defp authenticate_password(user, password), do: Authenticate.password(user, password)
end
