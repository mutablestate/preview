defmodule Preview.SignupController do
  use Phoenix.Controller
  alias Preview.Repo
  import Preview.Router.Helpers
  alias Phoenix.Controller.Flash
  alias Preview.Mailer

  plug :action

  def register(conn, params) do
    signup = %Preview.Signup{email: params["email"]}

    Repo.insert(signup)
    Mailer.send_welcome_email(signup)

    conn
    |> Flash.put(:success, "Thanks for registering #{params["email"]}! Check your email.")
    |> redirect to: root_path(:index)
  end
end
