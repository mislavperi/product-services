defmodule OrdersWeb.OrderItemsControllerTest do
  use OrdersWeb.ConnCase

  import Orders.TransactionsFixtures

  alias Orders.Transactions.OrderItems

  @create_attrs %{
    order_id: 42,
    order_item: "some order_item"
  }
  @update_attrs %{
    order_id: 43,
    order_item: "some updated order_item"
  }
  @invalid_attrs %{order_id: nil, order_item: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all order_items", %{conn: conn} do
      conn = get(conn, Routes.order_items_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create order_items" do
    test "renders order_items when data is valid", %{conn: conn} do
      conn = post(conn, Routes.order_items_path(conn, :create), order_items: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.order_items_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "order_id" => 42,
               "order_item" => "some order_item"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.order_items_path(conn, :create), order_items: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update order_items" do
    setup [:create_order_items]

    test "renders order_items when data is valid", %{conn: conn, order_items: %OrderItems{id: id} = order_items} do
      conn = put(conn, Routes.order_items_path(conn, :update, order_items), order_items: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.order_items_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "order_id" => 43,
               "order_item" => "some updated order_item"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, order_items: order_items} do
      conn = put(conn, Routes.order_items_path(conn, :update, order_items), order_items: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete order_items" do
    setup [:create_order_items]

    test "deletes chosen order_items", %{conn: conn, order_items: order_items} do
      conn = delete(conn, Routes.order_items_path(conn, :delete, order_items))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.order_items_path(conn, :show, order_items))
      end
    end
  end

  defp create_order_items(_) do
    order_items = order_items_fixture()
    %{order_items: order_items}
  end
end
