defmodule OrderableTest do
  use ExUnit.Case
  doctest Orderable

  setup do
    items = Enum.map(0..4, &%{name: "item-#{&1}", order: &1 * 10})

    [items: items]
  end

  describe "reorder/3 from 0" do
    test "move #0 to #-1", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-1", order: 10},
               %{name: "item-2", order: 20},
               %{name: "item-3", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 0, -1) |> Enum.sort_by(& &1.order)
    end

    test "move #0 to #0", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-1", order: 10},
               %{name: "item-2", order: 20},
               %{name: "item-3", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 0, 0) |> Enum.sort_by(& &1.order)
    end

    test "move #0 to #1", %{items: items} do
      assert [
               %{name: "item-1", order: 0},
               %{name: "item-0", order: 10},
               %{name: "item-2", order: 20},
               %{name: "item-3", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 0, 1) |> Enum.sort_by(& &1.order)
    end

    test "move #0 to #2", %{items: items} do
      assert [
               %{name: "item-1", order: 0},
               %{name: "item-2", order: 10},
               %{name: "item-0", order: 20},
               %{name: "item-3", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 0, 2) |> Enum.sort_by(& &1.order)
    end

    test "move #0 to #3", %{items: items} do
      assert [
               %{name: "item-1", order: 0},
               %{name: "item-2", order: 10},
               %{name: "item-3", order: 20},
               %{name: "item-0", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 0, 3) |> Enum.sort_by(& &1.order)
    end

    test "move #0 to #4", %{items: items} do
      assert [
               %{name: "item-1", order: 0},
               %{name: "item-2", order: 10},
               %{name: "item-3", order: 20},
               %{name: "item-4", order: 30},
               %{name: "item-0", order: 40}
             ] = Orderable.reorder(items, 0, 4) |> Enum.sort_by(& &1.order)
    end

    test "move #0 to #5", %{items: items} do
      assert [
               %{name: "item-1", order: 0},
               %{name: "item-2", order: 10},
               %{name: "item-3", order: 20},
               %{name: "item-4", order: 30},
               %{name: "item-0", order: 40}
             ] = Orderable.reorder(items, 0, 5) |> Enum.sort_by(& &1.order)
    end
  end

  describe "reorder/3 from 1" do
    test "move #1 to #-1", %{items: items} do
      assert [
               %{name: "item-1", order: 0},
               %{name: "item-0", order: 10},
               %{name: "item-2", order: 20},
               %{name: "item-3", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 1, -1) |> Enum.sort_by(& &1.order)
    end

    test "move #1 to #0", %{items: items} do
      assert [
               %{name: "item-1", order: 0},
               %{name: "item-0", order: 10},
               %{name: "item-2", order: 20},
               %{name: "item-3", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 1, 0) |> Enum.sort_by(& &1.order)
    end

    test "move #1 to #1", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-1", order: 10},
               %{name: "item-2", order: 20},
               %{name: "item-3", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 1, 1) |> Enum.sort_by(& &1.order)
    end

    test "move #1 to #2", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-2", order: 10},
               %{name: "item-1", order: 20},
               %{name: "item-3", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 1, 2) |> Enum.sort_by(& &1.order)
    end

    test "move #1 to #3", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-2", order: 10},
               %{name: "item-3", order: 20},
               %{name: "item-1", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 1, 3) |> Enum.sort_by(& &1.order)
    end

    test "move #1 to #4", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-2", order: 10},
               %{name: "item-3", order: 20},
               %{name: "item-4", order: 30},
               %{name: "item-1", order: 40}
             ] = Orderable.reorder(items, 1, 4) |> Enum.sort_by(& &1.order)
    end

    test "move #1 to #5", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-2", order: 10},
               %{name: "item-3", order: 20},
               %{name: "item-4", order: 30},
               %{name: "item-1", order: 40}
             ] = Orderable.reorder(items, 1, 5) |> Enum.sort_by(& &1.order)
    end
  end

  describe "reorder/3 from 2" do
    test "move #2 to #-1", %{items: items} do
      assert [
               %{name: "item-2", order: 0},
               %{name: "item-0", order: 10},
               %{name: "item-1", order: 20},
               %{name: "item-3", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 2, -1) |> Enum.sort_by(& &1.order)
    end

    test "move #2 to #0", %{items: items} do
      assert [
               %{name: "item-2", order: 0},
               %{name: "item-0", order: 10},
               %{name: "item-1", order: 20},
               %{name: "item-3", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 2, 0) |> Enum.sort_by(& &1.order)
    end

    test "move #2 to #1", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-2", order: 10},
               %{name: "item-1", order: 20},
               %{name: "item-3", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 2, 1) |> Enum.sort_by(& &1.order)
    end

    test "move #2 to #2", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-1", order: 10},
               %{name: "item-2", order: 20},
               %{name: "item-3", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 2, 2) |> Enum.sort_by(& &1.order)
    end

    test "move #2 to #3", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-1", order: 10},
               %{name: "item-3", order: 20},
               %{name: "item-2", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 2, 3) |> Enum.sort_by(& &1.order)
    end

    test "move #2 to #4", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-1", order: 10},
               %{name: "item-3", order: 20},
               %{name: "item-4", order: 30},
               %{name: "item-2", order: 40}
             ] = Orderable.reorder(items, 2, 4) |> Enum.sort_by(& &1.order)
    end

    test "move #2 to #5", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-1", order: 10},
               %{name: "item-3", order: 20},
               %{name: "item-4", order: 30},
               %{name: "item-2", order: 40}
             ] = Orderable.reorder(items, 2, 5) |> Enum.sort_by(& &1.order)
    end
  end

  describe "reorder/3 from 3" do
    test "move #3 to #-1", %{items: items} do
      assert [
               %{name: "item-3", order: 0},
               %{name: "item-0", order: 10},
               %{name: "item-1", order: 20},
               %{name: "item-2", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 3, -1) |> Enum.sort_by(& &1.order)
    end

    test "move #3 to #0", %{items: items} do
      assert [
               %{name: "item-3", order: 0},
               %{name: "item-0", order: 10},
               %{name: "item-1", order: 20},
               %{name: "item-2", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 3, 0) |> Enum.sort_by(& &1.order)
    end

    test "move #3 to #1", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-3", order: 10},
               %{name: "item-1", order: 20},
               %{name: "item-2", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 3, 1) |> Enum.sort_by(& &1.order)
    end

    test "move #3 to #2", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-1", order: 10},
               %{name: "item-3", order: 20},
               %{name: "item-2", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 3, 2) |> Enum.sort_by(& &1.order)
    end

    test "move #3 to #3", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-1", order: 10},
               %{name: "item-2", order: 20},
               %{name: "item-3", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 3, 3) |> Enum.sort_by(& &1.order)
    end

    test "move #3 to #4", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-1", order: 10},
               %{name: "item-2", order: 20},
               %{name: "item-4", order: 30},
               %{name: "item-3", order: 40}
             ] = Orderable.reorder(items, 3, 4) |> Enum.sort_by(& &1.order)
    end

    test "move #3 to #5", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-1", order: 10},
               %{name: "item-2", order: 20},
               %{name: "item-4", order: 30},
               %{name: "item-3", order: 40}
             ] = Orderable.reorder(items, 3, 5) |> Enum.sort_by(& &1.order)
    end
  end

  describe "reorder/3 from 4" do
    test "move #4 to #-1", %{items: items} do
      assert [
               %{name: "item-4", order: 0},
               %{name: "item-0", order: 10},
               %{name: "item-1", order: 20},
               %{name: "item-2", order: 30},
               %{name: "item-3", order: 40}
             ] = Orderable.reorder(items, 4, -1) |> Enum.sort_by(& &1.order)
    end

    test "move #4 to #0", %{items: items} do
      assert [
               %{name: "item-4", order: 0},
               %{name: "item-0", order: 10},
               %{name: "item-1", order: 20},
               %{name: "item-2", order: 30},
               %{name: "item-3", order: 40}
             ] = Orderable.reorder(items, 4, 0) |> Enum.sort_by(& &1.order)
    end

    test "move #4 to #1", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-4", order: 10},
               %{name: "item-1", order: 20},
               %{name: "item-2", order: 30},
               %{name: "item-3", order: 40}
             ] = Orderable.reorder(items, 4, 1) |> Enum.sort_by(& &1.order)
    end

    test "move #4 to #2", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-1", order: 10},
               %{name: "item-4", order: 20},
               %{name: "item-2", order: 30},
               %{name: "item-3", order: 40}
             ] = Orderable.reorder(items, 4, 2) |> Enum.sort_by(& &1.order)
    end

    test "move #4 to #3", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-1", order: 10},
               %{name: "item-2", order: 20},
               %{name: "item-4", order: 30},
               %{name: "item-3", order: 40}
             ] = Orderable.reorder(items, 4, 3) |> Enum.sort_by(& &1.order)
    end

    test "move #4 to #4", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-1", order: 10},
               %{name: "item-2", order: 20},
               %{name: "item-3", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 4, 4) |> Enum.sort_by(& &1.order)
    end

    test "move #4 to #5", %{items: items} do
      assert [
               %{name: "item-0", order: 0},
               %{name: "item-1", order: 10},
               %{name: "item-2", order: 20},
               %{name: "item-3", order: 30},
               %{name: "item-4", order: 40}
             ] = Orderable.reorder(items, 4, 5) |> Enum.sort_by(& &1.order)
    end
  end
end
