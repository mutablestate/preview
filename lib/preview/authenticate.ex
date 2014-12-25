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
end
