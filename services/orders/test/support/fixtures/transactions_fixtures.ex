defmodule Orders.TransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Orders.Transactions` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        account: "some account",
        status: "some status"
      })
      |> Orders.Transactions.create_order()

    order
  end

  @doc """
  Generate a order_items.
  """
  def order_items_fixture(attrs \\ %{}) do
    {:ok, order_items} =
      attrs
      |> Enum.into(%{
        order_id: 42,
        order_item: "some order_item"
      })
      |> Orders.Transactions.create_order_items()

    order_items
  end
end
