defmodule Preview.UserController do
  use Phoenix.Controller
  import Preview.Router.Helpers
  alias Preview.Repo
  alias Preview.Authenticate
  alias Comeonin.Bcrypt

  plug :action

  def index(conn, _params) do
    users = Preview.Queries.all_users
    signups = Preview.Queries.all_signups
    user = get_session(conn, :email)

    if Authenticate.user_session?(user, users) do
      render conn, "index.html", users: users,
                                 signups: signups,
                                 session: user
    else
      conn
      |> put_flash(:error, "Unauthorized!")
      |> render "login.html"
    end
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
    signups = Preview.Queries.all_signups

    csv_filename = signups
      |> to_csv(["id", "email"])

    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=#{csv_filename}")
    |> send_file(200, csv_filename)
  end

  defp to_csv(signups, headers) do
    header_line = CSVLixir.write(headers)

    csv_lines = signups
      |> Enum.map(fn s -> ["#{s.id}", "#{s.email}"] end)
      |> CSVLixir.write

    csv_data = header_line <> "\n" <> csv_lines
    csv_filename = "signups#{timestamp}.csv"

    csv_filename
    |> File.write(csv_data)

    csv_filename
  end

  defp timestamp do
    :erlang.now
    |> :calendar.now_to_universal_time
    |> :calendar.datetime_to_gregorian_seconds
    |> to_epoch_time
  end
  defp to_epoch_time(gregorian_seconds) do
    (gregorian_seconds) -719528*24*3600
  end
end
