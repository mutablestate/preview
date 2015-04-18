defmodule DocTest do
  use ExUnit.Case, async: true

  doctest Preview
  doctest Preview.LayoutView
end
