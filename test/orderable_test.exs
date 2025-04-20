defmodule OrderableTest do
  use ExUnit.Case
  doctest Orderable

  test "greets the world" do
    assert Orderable.hello() == :world
  end
end
