defmodule Orderable do
  @moduledoc """
  Orderable.
  """

  @type item() :: map() | struct()

  @doc """
  Reorder items.

  Items must be Map or Struct with ordering key.

  - `items` - An ordered list of items.
  - `from` - An index of item from. It must be `0` <= `from` < `length(items)`.
  - `to` - An index of item to. If it is less than to 0, it is considered to be 0, and if it is greater than or equal to the length of items, it is considered to be the end of items.

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

  def reorder(items, from, to)
      when is_list(items) and is_integer(from) and is_integer(to) and
             0 <= from and from < length(items) do
    to = if to > 0, do: to, else: 0

    do_reorder(items, from, to)
  end

  defp do_reorder(items, from, to) when from > to do
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

  defp do_reorder(items, from, to) when from < to do
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

  defp do_reorder(items, _, _), do: items

  defp update_item(item, order) when is_map(item) or is_struct(item) do
    %{item | order: order}
  end
end
