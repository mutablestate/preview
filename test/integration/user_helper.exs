defmodule UserHelper do
  alias Preview.Repo
  alias Preview.User
  alias Preview.Queries

  def create_user(username, password) do
    fields = [username: username, password: Comeonin.hashpwsalt(password)]
    user = struct(User, fields)
    Repo.insert(user)
  end

  def destroy_user(username) do
    user = Queries.find_by_username(username)
    Repo.delete(user)
  end
end
