defmodule Preview.SignupController do
  use Preview.Web, :controller

  alias Preview.Signup
  alias Preview.User
  alias Preview.Authenticate
  alias Preview.CsvHelper

  plug :scrub_params, "signup" when action in [:create]
  plug :action

  def index(conn, _params) do
    session_email = get_session(conn, :email)
    conn |> authenticate_action(session_email)

    signups = Repo.all(Signup)

    render conn, "index.html", signups: signups
  end

  def csv_export(conn, _params) do
    session_email = get_session(conn, :email)
    conn |> authenticate_action(session_email)

    signups = Repo.all(Signup)
    headers = [:id, :email]

    if CsvHelper.valid_headers?(headers, Signup) do
      csv_filename =
        signups
        |> CsvHelper.generate_csv(headers)
        |> CsvHelper.csv_to_file("signups")

      conn
      |> put_resp_content_type("text/csv")
      |> put_resp_header("content-disposition", "attachment; filename=#{csv_filename}")
      |> send_file(200, csv_filename)

    else
      IO.puts("Error: headers are invalid")
      conn
      |> fetch_flash
      |> put_flash(:error, "CSV header row is invalid")
      |> redirect to: signup_path(conn, :index)
    end
  end

  def authenticate_action(conn, nil), do: unauthorized(conn)
  def authenticate_action(conn, ""),  do: unauthorized(conn)
  def authenticate_action(conn, email) do
    users = Repo.all(User)
    session = Authenticate.session(users, email)

    case session do
      {:ok, message}    -> IO.puts(message)
      {:error, message} -> IO.puts(message)
        conn
        |> redirect to: login_path(conn, :login)
    end
  end

  def unauthorized(conn) do
    IO.puts("Unauthorized access attempt!")
    conn
    |> fetch_flash
    |> put_flash(:error, "Unauthorized!")
    |> redirect to: login_path(conn, :login)
  end

  def create(conn, %{"signup" => signup_params}) do
    changeset = Signup.changeset(%Signup{}, signup_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:success, "Signup created successfully.")
      |> redirect(to: root_path(conn, :index))
    else
      conn
      |> put_flash(:error, "Email validation failed.")
      |> redirect(to: root_path(conn, :index))
    end
  end
end
