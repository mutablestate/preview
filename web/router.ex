defmodule Preview.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", Preview do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index, as: :root

    get  "/users",        UserController, :index, as: :user
    get  "/users/new",    UserController, :new,   as: :user
    get  "/users/login",  UserController, :login, as: :user
    post "/users/login",  UserController, :login_process, as: :user
    get  "/users/logout", UserController, :logout, as: :user

    post "/signups/register", SignupController, :register, as: :signup
  end

  # Other scopes may use custom stacks.
  # scope "/api", Preview do
  #   pipe_through :api
  # end
end
