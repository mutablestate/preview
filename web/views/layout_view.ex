defmodule Preview.LayoutView do
  use Preview.Web, :view

  alias Phoenix.Controller

  @doc """
  Maps the first flash message level to a css class

  ## Examples

      iex> conn = %Plug.Conn{private: %{plug_session: %{}}}
      ...> conn |>
      ...> Phoenix.Controller.fetch_flash |>
      ...> Phoenix.Controller.put_flash(:notice, "Message!") |>
      ...> Preview.LayoutView.flash_class
      "flash-notice"
  """
  @spec flash_class(map) :: String.t
  def flash_class(conn), do: _flash_class(Controller.get_flash(conn))
  def _flash_class(%{"info" => _}),    do: "flash-notice"
  def _flash_class(%{"error" => _}),   do: "flash-error"
  def _flash_class(%{"alert" => _}),   do: "flash-alert"
  def _flash_class(%{"notice" => _}),  do: "flash-notice"
  def _flash_class(%{"success" => _}), do: "flash-success"
  def _flash_class(%{}), do: ""

  @doc """
  Returns the flash message string

  ## Examples

      iex> conn = %Plug.Conn{private: %{plug_session: %{}}}
      ...> conn |>
      ...> Phoenix.Controller.fetch_flash |>
      ...> Phoenix.Controller.put_flash(:notice, "Message!") |>
      ...> Preview.LayoutView.flash_message
      "Message!"
  """
  @spec flash_message(map) :: String.t
  def flash_message(conn) do
    flash = Controller.get_flash(conn)
    flash |> Map.values |> List.first
  end
end
