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
  - `opts` - Options.
      - `:fun` - A custom update-funciton.
      - `:key` - A ordering key.

  ### Examples

  #### Orders by `:order`

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

  #### Orders by `:sequence`

  ```elixir
  iex> items = [
  ...>   %{name: "one", sequence: 1},
  ...>   %{name: "two", sequence: 2},
  ...>   %{name: "three", sequence: 3},
  ...>   %{name: "four", sequence: 4},
  ...>   %{name: "five", sequence: 5}
  ...> ]
  iex> Orderable.reorder(items, 3, 1, key: :sequence) |> Enum.sort_by(& &1.sequence)
  [
    %{name: "one", sequence: 1},
    %{name: "four", sequence: 2},
    %{name: "two", sequence: 3},
    %{name: "three", sequence: 4},
    %{name: "five", sequence: 5}
  ]
  ```

  #### Updates by custom function

  ```elixir
  iex> items = [
  ...>   %{name: "one", order: 1},
  ...>   %{name: "two", order: 2},
  ...>   %{name: "three", order: 3},
  ...>   %{name: "four", order: 4},
  ...>   %{name: "five", order: 5}
  ...> ]
  iex> Orderable.reorder(items, 3, 1, fun: fn target, reference, key ->
  ...>                                       {target, %{key => reference[key]}}
  ...>                                     end)
  ...> |> Enum.sort_by(fn {_, %{order: order}} -> order end)
  [
    {%{name: "one", order: 1}, %{order: 1}},
    {%{name: "four", order: 4}, %{order: 2}},
    {%{name: "two", order: 2}, %{order: 3}},
    {%{name: "three", order: 3}, %{order: 4}},
    {%{name: "five", order: 5}, %{order: 5}}
  ]
  ```

  This option is intended for use with changesets etc.

  ```elixir
  Orderable.reorder(items, 3, 1, fun: &Item.chengeset(&1, %{&3 => &2[&3]))
  ```
  """

  @spec reorder([item()], integer(), integer(), keyword()) :: [item()]

  def reorder(items, from, to, opts \\ [])
      when is_list(items) and is_integer(from) and is_integer(to) and is_list(opts) and
             0 <= from and from < length(items) do
    update_fun = Keyword.get(opts, :fun, &update_item/3)
    key = Keyword.get(opts, :key, :order)

    to = if to > 0, do: to, else: 0

    do_reorder(items, from, to, update_fun, key)
  end

  defp do_reorder(items, from, to, update_fun, key) when from > to do
    {leading_items, rest} = Enum.split(items, to)
    {[target_head | _] = target_items, trailing_items} = Enum.split(rest, from - to + 1)

    updated_target_items =
      target_items
      |> Enum.chunk_every(2, 1)
      |> Enum.map(fn
        [item1, item2] -> update_fun.(item1, item2, key)
        [item] -> update_fun.(item, target_head, key)
      end)

    updated_leading_items = Enum.map(leading_items, &update_fun.(&1, &1, key))
    updated_trailing_items = Enum.map(trailing_items, &update_fun.(&1, &1, key))

    updated_leading_items ++ updated_target_items ++ updated_trailing_items
  end

  defp do_reorder(items, from, to, update_fun, key) when from < to do
    {leading_items, rest} = Enum.split(items, from)
    {[target_head | _] = target_items, trailing_items} = Enum.split(rest, to - from + 1)

    updated_target_items =
      target_items
      |> Enum.chunk_every(2, 1)
      |> Enum.map(fn
        [item1, item2] -> update_fun.(item2, item1, key)
        [item] -> update_fun.(target_head, item, key)
      end)

    updated_leading_items = Enum.map(leading_items, &update_fun.(&1, &1, key))
    updated_trailing_items = Enum.map(trailing_items, &update_fun.(&1, &1, key))

    updated_leading_items ++ updated_target_items ++ updated_trailing_items
  end

  defp do_reorder(items, _, _, _, _), do: items

  defguardp is_item(term) when is_map(term) or is_struct(term)

  defp update_item(target_item, reference_item, key)
       when is_item(target_item) and is_item(reference_item) do
    %{target_item | key => Map.get(reference_item, key)}
  end
end
