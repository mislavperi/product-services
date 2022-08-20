defmodule OrdersWeb.OrderItemsController do
  use OrdersWeb, :controller

  alias Orders.Transactions
  alias Orders.Transactions.OrderItems

  action_fallback OrdersWeb.FallbackController

  def index(conn, _params) do
    order_items = Transactions.list_order_items()
    render(conn, "index.json", order_items: order_items)
  end

  def create(conn, %{"order_items" => order_items_params}) do
    with {:ok, %OrderItems{} = order_items} <- Transactions.create_order_items(order_items_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.order_items_path(conn, :show, order_items))
      |> render("show.json", order_items: order_items)
    end
  end

  def show(conn, %{"id" => id}) do
    order_items = Transactions.get_order_items!(id)
    render(conn, "show.json", order_items: order_items)
  end

  def update(conn, %{"id" => id, "order_items" => order_items_params}) do
    order_items = Transactions.get_order_items!(id)

    with {:ok, %OrderItems{} = order_items} <- Transactions.update_order_items(order_items, order_items_params) do
      render(conn, "show.json", order_items: order_items)
    end
  end

  def delete(conn, %{"id" => id}) do
    order_items = Transactions.get_order_items!(id)

    with {:ok, %OrderItems{}} <- Transactions.delete_order_items(order_items) do
      send_resp(conn, :no_content, "")
    end
  end
end
