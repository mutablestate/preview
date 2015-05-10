defmodule Preview.SignupTest do
  use Preview.ModelCase

  alias Preview.Signup

  @valid_attrs %{email: "yoda@example.com"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Signup.changeset(%Signup{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Signup.changeset(%Signup{}, @invalid_attrs)
    refute changeset.valid?
  end
end
