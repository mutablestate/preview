defmodule Preview.UserControllerTest do
  use Preview.ConnCase

  test "GET login_path(conn, :login)" do
    conn = get conn(), "/users/login"
    assert conn.resp_body =~ "Login"
  end
end
