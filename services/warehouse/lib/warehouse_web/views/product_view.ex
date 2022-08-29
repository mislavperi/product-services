defmodule WarehouseWeb.ProductView do
  use WarehouseWeb, :view
  alias WarehouseWeb.ProductView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{
      id: product.id,
      product_id: product.product_id,
      amount: product.amount
    }
  end
end
