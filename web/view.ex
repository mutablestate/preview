defmodule Preview.View do
  use Phoenix.View, root: "web/templates"

  # The quoted expression returned by this block is applied
  # to this module and all other views that use this module.
  using do
    quote do
      # Import common functionality
      import Preview.Router.Helpers

      # Use Phoenix.HTML to import all HTML functions (forms, tags, etc)
      use Phoenix.HTML

      # Common aliases
      alias Phoenix.Controller
    end
  end

  def csrf_token(conn) do
    Plug.Conn.get_session(conn, :csrf_token)
  end

  @doc """
  Helper function to determine style class from the flash

  Returns a string

  ## Example

    iex> alias Phoenix.Controller
    ...> alias Plug.Conn
    ...> conn = %Conn{private: %{plug_session: %{}}}
    ...> conn |> Controller.fetch_flash |>
    ...> Controller.put_flash(:notice, "Message!") |>
    ...> Controller.get_flash |> Preview.View.flash_class
    "flash-notice"

  """
  def flash_class(map) do
    level = Map.keys(map)
      |> List.first

    case level do
      :notice  -> "flash-notice"
      :success -> "flash-success"
      :error   -> "flash-error"
      _ -> ""
    end
  end

  @doc """
  Helper function to extract the message from the flash

  Returns a string

  ## Example

    iex> alias Phoenix.Controller
    ...> alias Plug.Conn
    ...> conn = %Conn{private: %{plug_session: %{}}}
    ...> conn |> Controller.fetch_flash |>
    ...> Controller.put_flash(:notice, "Message!") |>
    ...> Controller.get_flash |> Preview.View.flash_message
    "Message!"

  """
  def flash_message(map) do
    map
    |> Map.values
    |> List.first
  end

  # Functions defined here are available to all other views/templates
end
