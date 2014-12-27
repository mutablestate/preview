defmodule Preview.Authenticate do
  import Comeonin

  @doc """
  Authenticates a non-hashed password matches the hashed password in a user struct

  Returns nil or user struct
  """
  def password(user, password) do
    authenticate_user(Comeonin.check_password(password, user.password), user)
  end

  defp authenticate_user(false, _),   do: nil
  defp authenticate_user(true, user), do: user

  @doc """
  Authenticates a session against registered users

  Returns boolean
  """
  def user_session?(user, users) do
    users
    |> Enum.map(fn user -> user.username end)
    |> Enum.member?(user)
  end
end
