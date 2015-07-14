defmodule Preview.UserController do
  use Preview.Web, :controller

  alias Preview.User

  def login(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "login.html", changeset: changeset
  end

  def authenticate_login(conn, %{"user" => user_params}) do
    email    = user_params["email"]
    password = user_params["password"]

    if required_params?(email, password) do
      case User.letmein(email, password) do
        {:error, message} ->
          conn
          |> put_flash(:error, message)
          |> redirect to: login_path(conn, :login)
        {:ok, _} ->
          conn
          |> put_flash(:success, "Welcome #{email}!")
          |> put_session(:email, email)
          |> redirect to: signup_path(conn, :index)
      end
    else
      conn
      |> put_flash(:error, "Please enter a valid email and password")
      |> redirect to: login_path(conn, :login)
    end
  end

  defp required_params?(_, ""), do: false
  defp required_params?("", _), do: false
  defp required_params?(_, _),  do: true

  def logout(conn, _params) do
    conn
    |> put_session(:email, "")
    |> put_flash(:notice, "You're logged out.")
    |> redirect to: root_path(conn, :index)
  end
end
