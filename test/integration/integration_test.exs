defmodule IntegrationTest do
  use ExUnit.Case, async: true
  use Hound.Helpers

  hound_session

  test "hound sanity" do
    navigate_to("http://localhost:4000/")
    assert("Preview Phoenix!" == page_title)
  end
end
