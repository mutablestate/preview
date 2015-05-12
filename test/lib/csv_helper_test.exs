defmodule Preview.CsvHelperTest do
  use ExUnit.Case, async: true
  alias Preview.CsvHelper, as: CSV

  defmodule Sith do
    defstruct id: "", email: ""
  end

  setup context do
    context = Dict.put(context, :headers, [:id, :email])
    context = Dict.put(context, :records, [%Sith{email: "darthmaul@example.com", id: 1}, %Sith{email: "emperor@example.com", id: 2}])
    {:ok, context}
  end

  ## valid_header?/2
  test "a list of atoms defined in the module struct is valid", context do
    assert CSV.valid_headers?(context.headers, Sith) == true
  end

  test "a list containing an undefined atom in the module struct is invalid" do
    undefined_atom = [:id, :email, :username]

    assert CSV.valid_headers?(undefined_atom, Sith) == false
  end

  test "a list containing a string causes an error" do
    invalid_type = [:id, "email"]

    assert_raise ArgumentError, "Header must contain atoms pre-defined in the passed module struct", fn ->
      CSV.valid_headers?(invalid_type, Sith)
    end
  end

  ## generate_csv/3
  test "generates csv content with headers by default", context do
    assert CSV.generate_csv(context.records, context.headers) == "id,email\n1,darthmaul@example.com\n2,emperor@example.com\n"
  end

  test "generates csv content without headers", context do
    assert CSV.generate_csv(context.records, context.headers, false) == "1,darthmaul@example.com\n2,emperor@example.com\n"
  end

  ## header_row/1
  test "header row", context do
    assert CSV.header_row(context.headers) == "id,email\n"
  end

  ## data_rows/2
  test "data rows", context do
    assert CSV.data_rows(context.records, context.headers) == "1,darthmaul@example.com\n2,emperor@example.com\n"
  end
end
