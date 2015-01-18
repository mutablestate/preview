defmodule Preview.AuthenticateTest do
  use ExUnit.Case, async: true
  alias Preview.Authenticate

  def letmein_user do
    %Preview.User{
      id: 1,
      password: "$2a$10$2EIByNPyYvI55PyzoQVeHe.XFYktolJRDse0m3Gl8v28cxdK8wusu",
      username: "obiwan@example.com"}
  end

  def users do
    [%Preview.User{
      id: 1,
      password: "$2a$10$2EIByNPyYvI55PyzoQVeHe.XFYktolJRDse0m3Gl8v28cxdK8wusu",
      username: "luke@example.com"},
    %Preview.User{
      id: 1,
      password: "$2a$10$2EIByNPyYvI55PyzoQVeHe.XFYktolJRDse0m3Gl8v28cxdK8wusu",
      username: "chewie@example.com"}]
  end

  # password/2
  test "matched password returns the user struct" do
    password = "letmein"
    assert Authenticate.password(letmein_user, password) == letmein_user
  end

  test "unmatched password returns nil" do
    password = "nochance"
    assert Authenticate.password(letmein_user, password) == nil
  end

  # user_session/2
  test "user in a session is a registered user" do
    user = "luke@example.com"
    assert Authenticate.user_session?(user, users) == true
  end

  test "user is not registered" do
    user = "boba@example.com"
    assert Authenticate.user_session?(user, users) == false
  end
end
