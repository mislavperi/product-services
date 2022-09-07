defmodule MainWeb.OrderController do
  use MainWeb, :controller

  alias Main.Order
  alias MainWeb.Warehouse

  action_fallback(MainWeb.FallbackController)

  def send_order(conn, params) do
    case Warehouse.reserve_stock(params) do
      :ok ->
        case Order.send_order(conn, params) do
          :ok -> nil
          :error -> send_resp(conn, 412, "kafka error")
        end

      :error ->
        send_resp(conn, 412, "error")
    end

    send_resp(conn, 200, "good")
  end
end
