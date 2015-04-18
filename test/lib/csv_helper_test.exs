defmodule Preview.CsvHelperTest do
  use ExUnit.Case, async: true
  alias Preview.CsvHelper, as: CSV

  defmodule Sith do
    defstruct id: "", email: ""
  end

  # valid_header?/2
  test "a list of atoms defined in the module struct is valid" do
    defined_atoms = [:id, :email]

    assert CSV.valid_headers?(defined_atoms, Sith) == true
  end

  test "a list containing an undefined atom in the module struct is invalid" do
    undefined_atoms = [:id, :email, :username]

    assert CSV.valid_headers?(undefined_atoms, Sith) == false
  end

  test "a list containing a string causes an error" do
    defined_atom_with_string = [:id, "email"]

    assert_raise ArgumentError, "Header must only contain atoms pre-defined in the passed module struct", fn ->
      CSV.valid_headers?(defined_atom_with_string, Sith)
    end
  end

  # generate_csv/3
  test "generates csv content with headers by default" do
    records = [%Sith{email: "darthmaul@example.com", id: 1}, %Sith{email: "emperor@example.com", id: 2}]
    headers = [:id, :email]

    assert CSV.generate_csv(records, headers) == "id,email\n1,darthmaul@example.com\n2,emperor@example.com"
  end

  test "generates csv content without headers" do
    records = [%Sith{email: "darthmaul@example.com", id: 1}, %Sith{email: "emperor@example.com", id: 2}]
    headers = [:id, :email]

    assert CSV.generate_csv(records, headers, false) == "1,darthmaul@example.com\n2,emperor@example.com"
  end
end
