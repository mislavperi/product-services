defmodule MainWeb.ProductController do
  use MainWeb, :controller

  alias Main.Catalog
  alias Main.Catalog.Product
  alias Req

  action_fallback(MainWeb.FallbackController)

  def index(conn, _params) do
    products = Catalog.list_products()

    stocked_map = Req.get!("http://warehouse-service:4000/api/v1/warehouse").body

    stocked_items =
      Enum.map(stocked_map["data"], fn item ->
        Catalog.get_product!(item["product_id"])
      end)

    render(conn, "index.json", products: stocked_items)
  end

  def create(conn, %{"product" => product_params}) do
    with {:ok, %Product{} = product} <- Catalog.create_product(product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.product_path(conn, :show, product))
      |> render("show.json", product: product)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Catalog.get_product!(id)
    render(conn, "show.json", product: product)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Catalog.get_product!(id)

    with {:ok, %Product{} = product} <- Catalog.update_product(product, product_params) do
      render(conn, "show.json", product: product)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Catalog.get_product!(id)

    with {:ok, %Product{}} <- Catalog.delete_product(product) do
      send_resp(conn, :no_content, "")
    end
  end
end
