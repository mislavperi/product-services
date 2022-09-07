defmodule Warehouse do
  alias Warehouse.Stock
  alias Warehouse.Stock.Product
  alias Ecto
  alias Warehouse.Repo

  @moduledoc """
  Warehouse keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def reserve_stock(items) do
    Enum.each(
      Map.get(items, "_json"),
      fn item ->
        product = Stock.get_product_by_fk(item["product_id"])

        if Map.get(product, :product_id) - item["amount"] < 0 do
          raise "Product request is more than amount in stock"
        end
      end
    )

    Enum.each(
      Map.get(items, "_json"),
      fn item ->
        product = Stock.get_product_by_fk(item["product_id"])

        Product.changeset(product, %{
          amount: Map.get(product, :amount) - item["amount"]
        })
        |> Repo.update()
      end
    )
  end
end
