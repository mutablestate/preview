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
      |> Enum.all?(fn header -> Enum.member?(keys, header) end)
    else
      raise ArgumentError, message: "Header must contain atoms pre-defined in the passed module struct"
    end
  end

  defp fetch_keys(module) do
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
      true -> header_row(headers) <> data_rows(records)
      _ -> data_rows(records)
    end
  end

  def header_row(headers) do
    headers
    |> Enum.map(fn header -> Atom.to_string(header) end)
    |> CSVLixir.write_row
  end

  def data_rows(records) do
    records
    |> list_rows
    |> CSVLixir.write
    |> Enum.to_list
    |> Enum.join
  end

  defp list_rows(records) do
    records
    |> Enum.map(fn record -> Map.from_struct(record)
      |> Map.values
      |> Enum.reverse
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
    :erlang.now
    |> :calendar.now_to_universal_time
    |> :calendar.datetime_to_gregorian_seconds
    |> to_epoch_time
  end
  defp to_epoch_time(gregorian_seconds) do
    (gregorian_seconds) -719528*24*3600
  end
end
