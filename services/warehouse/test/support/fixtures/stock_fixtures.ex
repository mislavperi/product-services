defmodule Warehouse.StockFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Warehouse.Stock` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> Warehouse.Stock.create_product()

    product
  end
end
