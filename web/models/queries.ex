defmodule Preview.Queries do
  import Ecto.Query

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
    md5_password = Preview.Crypto.md5(password)
    query = from user in Preview.User,
            where: user.username == ^username,
            where: user.password == ^md5_password,
            select: user

    Preview.Repo.one(query)
  end
end
