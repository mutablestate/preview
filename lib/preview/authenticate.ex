defmodule Preview.Authenticate do
  alias Comeonin.Bcrypt

  @doc """
  Authenticates a non-hashed password matches the hashed password in a user struct

  Returns nil or user struct
  """
  def password(user, password) do
    _password(Bcrypt.checkpw(password, user.password), user)
  end
  defp _password(false, _),   do: nil
  defp _password(true, user), do: user

  @doc """
  Authenticates a session against registered users

  Returns boolean
  """
  def user_session?(user, users) do
    users
    |> Enum.map(fn user -> user.email end)
    |> Enum.member?(user)
  end
end
