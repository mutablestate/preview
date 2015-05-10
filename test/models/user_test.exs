defmodule Preview.UserTest do
  use Preview.ModelCase

  alias Preview.User

  @valid_attrs %{email: "yoda@example.com", password: "hashed"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
