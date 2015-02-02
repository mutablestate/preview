defmodule Preview.UserController do
  use Phoenix.Controller
  import Preview.Router.Helpers
  alias Preview.Repo
  alias Preview.Authenticate
  alias Preview.CsvHelper
  alias Comeonin.Bcrypt

  plug :action

  def index(conn, _params) do
    user = get_session(conn, :email)
    user
    |> authenticate_action?(conn)

    users = Preview.Queries.all_users
    signups = Preview.Queries.all_signups

    render conn, "index.html", users: users,
                               signups: signups,
                               session: user
  end

  def new(conn, _params) do
    render conn, "new.html", user: %Preview.User{}
  end

  def create(conn, params) do
    user = %Preview.User{email: params["email"],
                         password: Bcrypt.hashpwsalt(params["password"])}

    Repo.insert(user)
    redirect conn, :index
  end

  def login(conn, _params) do
    render conn, "login.html"
  end

  def login_process(conn, params) do
    user = Preview.Queries.login(params["email"], params["password"])

    if user == nil do
      conn
      |> put_flash(:error, "Incorrect email and or password")
      |> render "login.html"
    else
      conn
      |> put_flash(:notice, "Welcome #{params["email"]}!")
      |> put_session(:email, params["email"])
      |> redirect to: user_path(conn, :index)
    end
  end

  def logout(conn, _params) do
    conn
    |> put_session(:email, "")
    |> put_flash(:notice, "You're logged out.")
    |> redirect to: root_path(conn, :index)
  end

  def signups(conn, _params) do
    user = get_session(conn, :email)
    user
    |> authenticate_action?(conn)

    signups = Preview.Queries.all_signups
    headers = [:id, :email]

    if CsvHelper.valid_headers?(headers, Preview.Signup) do
      csv_filename = signups
        |> CsvHelper.generate_csv(headers)
        |> CsvHelper.csv_to_file("signups")

      conn
      |> put_resp_content_type("text/csv")
      |> put_resp_header("content-disposition", "attachment; filename=#{csv_filename}")
      |> send_file(200, csv_filename)
    else
      IO.puts "Error please check headers are valid"
      conn
      |> fetch_flash
      |> put_flash(:error, "CSV header error")
      |> redirect to: user_path(conn, :index)
    end
  end

  defp authenticate_action?(user, conn) do
    users = Preview.Queries.all_users

    if Authenticate.user_session?(user, users) do
      IO.puts "User authorized"
    else
      IO.puts "Unauthorized access attempted!"
      conn
      |> fetch_flash
      |> put_flash(:error, "Unauthorized!")
      |> render "login.html"
    end
  end
end
