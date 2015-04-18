defmodule Preview.PageControllerTest do
  use Preview.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert conn.resp_body =~ "Register for news and updates"
  end
end
