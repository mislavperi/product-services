defmodule Warehouse do
  alias Warehouse.Stock
  alias Warehouse.Stock.Product

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
        IO.inspect(Stock.get_product_by_fk(item["product_id"]))
      end
    )
  end
end
