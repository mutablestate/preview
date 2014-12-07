defmodule Preview.SignupController do
  use Phoenix.Controller
  alias Preview.Repo
  import Preview.Router.Helpers
  alias Phoenix.Controller.Flash
  alias Preview.Mailer

  plug :action

  @doc """
  Registers new emails and sends a welcome email
  Returns flash message and redirect path
  """
  def register(conn, params) do
    signup = %Preview.Signup{email: params["email"]}
    signups = Preview.Queries.all_signups

    if signed_up?(signup, signups) do
      conn
      |> Flash.put(:error, "Email already signed up!")
      |> redirect to: root_path(:index)
    else
      Repo.insert(signup)
      Mailer.send_welcome_email(signup)

      conn
      |> Flash.put(:success, "Thanks for registering #{params["email"]}! Check your email.")
      |> redirect to: root_path(:index)
    end
  end

  @doc """
  Check for already signed up emails
  Returns boolean
  """
  def signed_up?(signup, signups) do
    signups
    |> Enum.map(fn signup -> signup.email end)
    |> Enum.member?(signup.email)
  end

  #TODO check only valid email address format is entered
end
