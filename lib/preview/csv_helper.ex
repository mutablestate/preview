defmodule Preview.CsvHelper do
  @extension ".csv"

  @doc """
  Checks all headers are atoms and defined within the module struct
  Returns boolean or raises ArgumentError
  """
  @spec valid_headers?([atom], map) :: boolean
  def valid_headers?(headers, module) do
    if atoms?(headers) == true do
      keys = fetch_keys(module)

      headers
      |> Enum.all?(fn header -> header in keys end)
    else
      raise ArgumentError, message: "Header must contain atoms pre-defined in the passed module struct"
    end
  end

  def fetch_keys(module) do
    struct(module)
    |> Map.keys
    |> List.delete_at(0)
  end

  defp atoms?(headers) do
    headers
    |> Enum.all?(fn header -> is_atom(header) end)
  end

  @doc """
  Generates csv content from a query
  Returns data in csv format
  """
  @spec generate_csv(list(map), [atom], boolean) :: String.t
  def generate_csv(records, headers, return_headers \\ true) do
    case return_headers do
      true -> header_row(headers) <> data_rows(records, headers)
      _ -> data_rows(records, headers)
    end
  end

  def header_row(headers) do
    headers
    |> Enum.map(fn header -> Atom.to_string(header) end)
    |> CSVLixir.write_row
  end

  def data_rows(records, headers) do
    records
    |> filter_columns(headers)
    |> CSVLixir.write
    |> Enum.to_list
    |> Enum.join
  end

  def filter_columns(records, headers) do
    Enum.map(records, fn record ->
      headers |> Enum.map &(Map.get(record, &1))
    end)
  end

  @doc """
  Writes csv content to a filename adding a unix timestamp and extension
  Returns path to the written file
  """
  @spec csv_to_file(list, String.t) :: String.t
  def csv_to_file(csv_content, filename) do
    csv_path = "#{filename}-#{timestamp}" <> @extension
    csv_path |> File.write(csv_content)
    csv_path
  end

  defp timestamp do
    :erlang.system_time(:seconds)
  end
end
