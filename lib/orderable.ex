defmodule Orderable do
  @moduledoc """
  Orderable.
  """

  @type item() :: map() | struct()

  @doc """
  Reorder items.

  Items must be Map or Struct with ordering key.

  - `items` - ordered list of items.
  - `from` - index of item from.
  - `to` - index of item to.

  ```elixir
  iex> items = [
  ...>   %{name: "one", order: 1},
  ...>   %{name: "two", order: 2},
  ...>   %{name: "three", order: 3},
  ...>   %{name: "four", order: 4},
  ...>   %{name: "five", order: 5}
  ...> ]
  iex> Orderable.reorder(items, 3, 1) |> Enum.sort_by(& &1.order)
  [
    %{name: "one", order: 1},
    %{name: "four", order: 2},
    %{name: "two", order: 3},
    %{name: "three", order: 4},
    %{name: "five", order: 5}
  ]
  ```
  """
  @spec reorder([item()], integer(), integer()) :: [item()]

  def reorder(items, from, to) when is_integer(from) and is_integer(to) and to < 0 do
    reorder(items, from, 0)
  end

  def reorder(items, from, to) when is_integer(from) and is_integer(to) and from > to do
    {leading_items, rest} = Enum.split(items, to)
    {[target_head | _] = target_items, trailing_items} = Enum.split(rest, from - to + 1)

    target_items =
      target_items
      |> Enum.chunk_every(2, 1)
      |> Enum.map(fn
        [item1, item2] -> update_item(item1, item2.order)
        [item] -> update_item(item, target_head.order)
      end)

    leading_items ++ target_items ++ trailing_items
  end

  def reorder(items, from, to) when is_integer(from) and is_integer(to) and from < to do
    {leading_items, rest} = Enum.split(items, from)
    {[target_head | _] = target_items, trailing_items} = Enum.split(rest, to - from + 1)

    target_items =
      target_items
      |> Enum.chunk_every(2, 1)
      |> Enum.map(fn
        [item1, item2] -> update_item(item2, item1.order)
        [item] -> update_item(target_head, item.order)
      end)

    leading_items ++ target_items ++ trailing_items
  end

  def reorder(items, _, _), do: items

  defp update_item(item, order) when is_map(item) or is_struct(item) do
    %{item | order: order}
  end
end
