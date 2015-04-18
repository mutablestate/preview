defmodule Preview.Authenticate do
  alias Comeonin.Bcrypt

  @doc """
  Checks the hashed and non-hashed passwords match

  Returns {:ok, user} or {:error, message} tuple
  """
  def password(user, password) do
    check_password =
      password
      |> Bcrypt.checkpw(user.password)

    _password(check_password, user)
  end
  defp _password(false, _),   do: {:error, "Please enter a valid email and password"}
  defp _password(true, user), do: {:ok, user}

  @doc """
  Checks an email is in the users table

  Returns {:ok, message} or {:error, message} tuple
  """
  def session(users, email) do
    email_check =
      users
      |> Enum.map(fn user -> user.email end)
      |> Enum.member?(email)

    case email_check do
      false -> {:error, "Unauthorized access attempt!"}
      true  -> {:ok,    "User access granted!"}
    end
  end
end
