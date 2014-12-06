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
  Helper function receives the output from Flash.get(conn)
  Maps the key to a template css class

  Examples
    iex> Flash.put(conn, :notice, "Message!")
    iex> flash_class(Flash.get(@conn))
    iex> "flash-notice"
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
  Helper function takes output from Flash.get(conn)
  Returns the message

  Examples
    iex> Flash.put(conn, :notice, "Message!")
    iex> flash_notice(Flash.get(@conn))
    iex> "Message!"
  """
  def flash_notice(map) do
    map
    |> Map.values
    |> List.first
  end

  # Functions defined here are available to all other views/templates
end
