defmodule Preview.PageController do
  use Preview.Web, :controller

  alias Preview.Signup

  def index(conn, _params) do
    changeset = Signup.changeset(%Signup{})

    render conn, "index.html", changeset: changeset
  end
end
