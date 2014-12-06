defmodule Preview.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/" do
    pipe_through :browser

    get "/", Preview.PageController, :index, as: :root

    get  "/users",        Preview.UserController, :index, as: :user
    get  "/users/new",    Preview.UserController, :new,   as: :user
    get  "/users/login",  Preview.UserController, :login, as: :user
    post "/users/login",  Preview.UserController, :login_process, as: :user
    get  "/users/logout", Preview.UserController, :logout, as: :user

    post "/signups/register", Preview.SignupController, :register, as: :signup
  end
end
