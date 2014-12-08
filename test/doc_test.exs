defmodule DocTest do
  use ExUnit.Case, async: true

  doctest Preview
  doctest Preview.View
end
