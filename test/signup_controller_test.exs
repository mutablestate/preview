defmodule Preview.SignupControllerTest do
  use ExUnit.Case, async: true
  alias Preview.SignupController

  def signups do
    [ %Preview.Signup{email: "luke@example.com",  id: 1},
      %Preview.Signup{email: "darth@example.com", id: 2},
      %Preview.Signup{email: "yoda@example.com",  id: 3},
      %Preview.Signup{email: "han@example.com",   id: 4} ]
  end

  # signed_up?/1
  test "recognises a repeat email signup" do
    signup = %Preview.Signup{email: "han@example.com", id: nil}
    assert SignupController.signed_up?(signup, signups) == true
  end

  test "recognises a new email sign up" do
    signup = %Preview.Signup{email: "bobafet@example.com", id: nil}
    assert SignupController.signed_up?(signup, signups) == false
  end
end
