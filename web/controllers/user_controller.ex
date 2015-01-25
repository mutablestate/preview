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
end
