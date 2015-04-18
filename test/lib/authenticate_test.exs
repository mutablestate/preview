defmodule Preview.AuthenticateTest do
  use ExUnit.Case, async: true
  alias Preview.Authenticate

  def letmein_user do
    %Preview.User{
      id: 1,
      password: "$2a$10$2EIByNPyYvI55PyzoQVeHe.XFYktolJRDse0m3Gl8v28cxdK8wusu",
      email: "obiwan@example.com"}
  end

  def users do
    [%Preview.User{
      id: 1,
      password: "$2a$10$2EIByNPyYvI55PyzoQVeHe.XFYktolJRDse0m3Gl8v28cxdK8wusu",
      email: "luke@example.com"},
    %Preview.User{
      id: 1,
      password: "$2a$10$2EIByNPyYvI55PyzoQVeHe.XFYktolJRDse0m3Gl8v28cxdK8wusu",
      email: "chewie@example.com"}]
  end

  # password/2
  test "matched password returns the :ok user struct tuple" do
    password = "letmein"

    assert Authenticate.password(letmein_user, password) == {:ok, letmein_user}
  end

  test "unmatched password returns the :error message tuple" do
    password = "nochance"

    assert Authenticate.password(letmein_user, password) == {:error, "Please enter a valid email and password"}
  end

  # session/2
  test "user email in the session is a registered user" do
    user = "luke@example.com"

    assert Authenticate.session(users, user) == {:ok, "User access granted!"}
  end

  test "user email in the session is not a registered user" do
    user = "boba@example.com"

    assert Authenticate.session(users, user) == {:error, "Unauthorized access attempt!"}
  end
end
