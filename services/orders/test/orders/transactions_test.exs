defmodule Orders.TransactionsTest do
  use Orders.DataCase

  alias Orders.Transactions

  describe "orders" do
    alias Orders.Transactions.Order

    import Orders.TransactionsFixtures

    @invalid_attrs %{account: nil, status: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Transactions.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Transactions.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{account: "some account", status: "some status"}

      assert {:ok, %Order{} = order} = Transactions.create_order(valid_attrs)
      assert order.account == "some account"
      assert order.status == "some status"
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{account: "some updated account", status: "some updated status"}

      assert {:ok, %Order{} = order} = Transactions.update_order(order, update_attrs)
      assert order.account == "some updated account"
      assert order.status == "some updated status"
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_order(order, @invalid_attrs)
      assert order == Transactions.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Transactions.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Transactions.change_order(order)
    end
  end

  describe "order_items" do
    alias Orders.Transactions.OrderItems

    import Orders.TransactionsFixtures

    @invalid_attrs %{order_id: nil, order_item: nil}

    test "list_order_items/0 returns all order_items" do
      order_items = order_items_fixture()
      assert Transactions.list_order_items() == [order_items]
    end

    test "get_order_items!/1 returns the order_items with given id" do
      order_items = order_items_fixture()
      assert Transactions.get_order_items!(order_items.id) == order_items
    end

    test "create_order_items/1 with valid data creates a order_items" do
      valid_attrs = %{order_id: 42, order_item: "some order_item"}

      assert {:ok, %OrderItems{} = order_items} = Transactions.create_order_items(valid_attrs)
      assert order_items.order_id == 42
      assert order_items.order_item == "some order_item"
    end

    test "create_order_items/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_order_items(@invalid_attrs)
    end

    test "update_order_items/2 with valid data updates the order_items" do
      order_items = order_items_fixture()
      update_attrs = %{order_id: 43, order_item: "some updated order_item"}

      assert {:ok, %OrderItems{} = order_items} = Transactions.update_order_items(order_items, update_attrs)
      assert order_items.order_id == 43
      assert order_items.order_item == "some updated order_item"
    end

    test "update_order_items/2 with invalid data returns error changeset" do
      order_items = order_items_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_order_items(order_items, @invalid_attrs)
      assert order_items == Transactions.get_order_items!(order_items.id)
    end

    test "delete_order_items/1 deletes the order_items" do
      order_items = order_items_fixture()
      assert {:ok, %OrderItems{}} = Transactions.delete_order_items(order_items)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_order_items!(order_items.id) end
    end

    test "change_order_items/1 returns a order_items changeset" do
      order_items = order_items_fixture()
      assert %Ecto.Changeset{} = Transactions.change_order_items(order_items)
    end
  end
end
