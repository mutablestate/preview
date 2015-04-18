defmodule Preview.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :csv do
    plug :accepts, ["csv"]
    plug :fetch_session
  end

  scope "/", Preview do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index, as: :root

    get  "/users/login",  UserController, :login,  as: :login
    post "/users/login",  UserController, :authenticate_login, as: :login
    post "/users/logout", UserController, :logout, as: :logout

    post "/signups/create", SignupController, :create
    get  "/signups",        SignupController, :index
  end

  scope "/signups", Preview do
    pipe_through :csv

    post "/export", SignupController, :csv_export
  end

  # Other scopes may use custom stacks.
  # scope "/api", Preview do
  #   pipe_through :api
  # end
end
