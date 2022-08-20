defmodule OrdersWeb.OrderItemsView do
  use OrdersWeb, :view
  alias OrdersWeb.OrderItemsView

  def render("index.json", %{order_items: order_items}) do
    %{data: render_many(order_items, OrderItemsView, "order_items.json")}
  end

  def render("show.json", %{order_items: order_items}) do
    %{data: render_one(order_items, OrderItemsView, "order_items.json")}
  end

  def render("order_items.json", %{order_items: order_items}) do
    %{
      id: order_items.id,
      order_id: order_items.order_id,
      order_item: order_items.order_item
    }
  end
end
