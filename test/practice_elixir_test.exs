defmodule PracticeElixirTest do
  use ExUnit.Case
  doctest PracticeElixir

  @list [
    %{id: 1, list: [1]},
    %{id: 1, list: [2]},
    %{id: 2, list: [1]},
    %{id: 3, list: [1]},
    %{id: 1, list: [3, 4, 5]}
  ]

  test "combine list with the same id using group_by" do
    assert [%{id: 1, list: [1, 2, 3, 4, 5]}, %{id: 2, list: [1]}, %{id: 3, list: [1]}] ==
             PracticeElixir.groupby_enum_map(@list)
  end

  test "combine list with the same id using reduce" do
    assert [%{id: 1, list: [1, 2, 3, 4, 5]}, %{id: 2, list: [1]}, %{id: 3, list: [1]}] ==
             PracticeElixir.reduce_enum_map(@list)
  end
end
