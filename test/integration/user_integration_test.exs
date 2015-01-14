defmodule UserIntegrationTest do
  use ExUnit.Case, async: true
  use Hound.Helpers

  alias UserHelper, as: Helper

  hound_session

  @base_url  "http://localhost:4001/"
  @username  "vader@example.com"
  @password  "deathstar"

  setup do
    Helper.create_user(@username, @password)

    on_exit fn ->
      Helper.destroy_user(@username)
    end
  end

  def submit_valid_login do
    input_into_field({:name, "username"}, @username)
    input_into_field({:name, "password"}, @password)

    click({:class, "submit-form"})
  end

  @tag integration: true
  test "unauthorized visitor notification and login form render" do
    navigate_to @base_url <> "users"

    assert visible_text({:class, "flash-error"}) == "Unauthorized!"
    assert visible_text({:class, "submit-form"}) == "Login"
  end

  @tag integration: true
  test "unregistered user login attempt notification and login form render" do
    navigate_to @base_url <> "users/login"

    input_into_field({:name, "username"}, "obi-wan@example.com")
    input_into_field({:name, "password"}, "usetheforce")

    click({:class, "submit-form"})

    assert visible_text({:class, "submit-form"}) == "Login"
    assert visible_text({:class, "flash-error"}) == "Incorrect username and or password"
  end

  @tag integration: true
  test "registered user login redirects to users page with notification" do
    navigate_to @base_url <> "users/login"
    submit_valid_login

    assert current_url == @base_url <> "users"
    assert visible_text({:class, "flash-notice"}) == "Welcome #{@username}!"

    click({:class, "logout"})
  end

  @tag integration: true
  test "logout redirects to root path with notification" do
    navigate_to @base_url <> "users/login"
    submit_valid_login
    click({:class, "logout"})

    assert current_url == @base_url
    assert visible_text({:class, "flash-notice"}) == "You're logged out."
  end
end
