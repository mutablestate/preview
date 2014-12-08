defmodule Preview.View do
  use Phoenix.View, root: "web/templates"

  # The quoted expression returned by this block is applied
  # to this module and all other views that use this module.
  using do
    quote do
      # Import common functionality
      import Preview.I18n
      import Preview.Router.Helpers

      # Use Phoenix.HTML to import all HTML functions (forms, tags, etc)
      use Phoenix.HTML

      # Common aliases
      alias Phoenix.Controller.Flash
    end
  end

  @doc """
  Helper function to determine style class from a flash
  Returns a string

  ## Example

    iex> alias Plug.Conn
    iex> alias Phoenix.Controller.Flash
    iex> conn = %Conn{private: %{plug_session: %{}}}
    iex> Flash.put(conn, :error, "Message!") |> Flash.get |> Preview.View.flash_class
    "flash-error"

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
  Helper function to extract the message from a flash
  Returns a list

  ## Example

    iex> alias Plug.Conn
    iex> alias Phoenix.Controller.Flash
    iex> conn = %Conn{private: %{plug_session: %{}}}
    iex> Flash.put(conn, :notice, "Message!") |> Flash.get |> Preview.View.flash_message
    ["Message!"]

  """
  def flash_message(map) do
    map
    |> Map.values
    |> List.first
  end

  # Functions defined here are available to all other views/templates
end
