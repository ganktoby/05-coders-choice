defmodule BJTest do
  use ExUnit.Case
  doctest BJ

  test "greets the world" do
    assert BJ.hello() == :world
  end
end
