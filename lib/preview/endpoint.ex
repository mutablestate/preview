defmodule Preview.Endpoint do
  use Phoenix.Endpoint, otp_app: :preview

  plug Plug.Static,
    at: "/", from: :preview

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_preview_key",
    signing_salt: "Vg9f5RLb",
    encryption_salt: "rlaLMzZY"

  plug :router, Preview.Router
end
