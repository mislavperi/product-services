defmodule WarehouseWeb.ProductController do
  use WarehouseWeb, :controller

  alias Warehouse.Stock
  alias Warehouse.Stock.Product

  action_fallback WarehouseWeb.FallbackController

  def index(conn, _params) do
    products = Stock.list_products()
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"product" => product_params}) do
    with {:ok, %Product{} = product} <- Stock.create_product(product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.product_path(conn, :show, product))
      |> render("show.json", product: product)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Stock.get_product!(id)
    render(conn, "show.json", product: product)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Stock.get_product!(id)

    with {:ok, %Product{} = product} <- Stock.update_product(product, product_params) do
      render(conn, "show.json", product: product)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Stock.get_product!(id)

    with {:ok, %Product{}} <- Stock.delete_product(product) do
      send_resp(conn, :no_content, "")
    end
  end
end
