defmodule PracticeElixir do
  @moduledoc """
  Documentation for `PracticeElixir`.
  """
  alias Benchee

  def groupby(list) do
    Enum.group_by(list, & &1.id)
  end

  def reduce(list) do
    list
    |> Enum.reverse()
    |> Enum.reduce(%{}, fn %{id: id, list: _list} = f, acc ->
      case acc do
        %{^id => existing} -> Map.put(acc, id, [f | existing])
        %{} -> Map.put(acc, id, [f])
      end
    end)
  end

  def groupby_enum_map(list) do
    list
    |> groupby()
    |> Enum.map(fn {id, list} -> %{id: id, list: Enum.flat_map(list, & &1.list)} end)
  end

  def groupby_stream_map(list) do
    list
    |> groupby()
    |> Stream.map(fn {id, list} -> %{id: id, list: Enum.flat_map(list, & &1.list)} end)
    |> Enum.into([])
  end

  def reduce_enum_map(list) do
    list
    |> reduce()
    |> Enum.map(fn {id, list} -> %{id: id, list: Enum.flat_map(list, & &1.list)} end)
  end

  def reduce_stream_map(list) do
    list
    |> reduce()
    |> Stream.map(fn {id, list} -> %{id: id, list: Enum.flat_map(list, & &1.list)} end)
    |> Enum.into([])
  end

  @list [
    %{id: 1, list: [1]},
    %{id: 1, list: [2]},
    %{id: 2, list: [1]},
    %{id: 3, list: [1]},
    %{id: 1, list: [3, 4, 5]},
    %{id: 2, list: [2, 3]},
    %{id: 3, list: [2, 3, 4, 5]},
    %{id: 4, list: [2, 3, 4, 5]},
    %{id: 4, list: [1]}
  ]
  def run do
    Benchee.run(
      %{
        "groupby_enum_map" => fn -> PracticeElixir.groupby_enum_map(@list) end,
        "reduce_enum_map" => fn -> PracticeElixir.reduce_enum_map(@list) end
      },
      print: [fast_warning: false]
    )
  end
end
