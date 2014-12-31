defmodule Preview.Queries do
  import Ecto.Query
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

    _login(user, password)
  end
  defp _login(nil, _) do
    Comeonin.dummy_checkpw
    nil
  end
  defp _login(user, password), do: Authenticate.password(user, password)
end
