defmodule Preview.Endpoint do
  use Phoenix.Endpoint, otp_app: :preview

  socket "/ws", Preview.UserSocket

  # Serve at "/" the given assets from "priv/static" directory
  plug Plug.Static,
    at: "/", from: :preview,
    only: ~w(css images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_preview_key",
    signing_salt: "W3ASBfEZ"

  plug Preview.Router
end
