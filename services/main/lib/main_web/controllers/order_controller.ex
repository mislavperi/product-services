defmodule MainWeb.OrderController do
  use MainWeb, :controller

  alias Main.Order

  action_fallback(MainWeb.FallbackController)

  def send_order(conn, _params) do
    Order.send_order()
    text(conn, "SENT")
  end
end
