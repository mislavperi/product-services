defmodule Main.Order do
  import Joken
  import Phoenix.Controller, only: [json: 2, put_view: 2, render: 3]
  import URI
  import Plug.Conn

  def send_order(conn, params) do
    sub = get_sub(conn)

    case get_token(conn) do
      {:ok, token} ->
        req = Req.new(url: URI.encode("https://dev-jy4007c0.us.auth0.com/api/v2/users/" <> sub))
        req = Req.Request.put_header(req, "Authorization", "Bearer " <> token)

        Enum.each(params["_json"], fn item ->
          value = %{
            email: Req.get!(req).body["email"],
            product_id: item["product_id"],
            amount: item["amount"]
          }

          encoded = Jason.encode!(value)
          :brod.produce_sync(:kafka_client, "products.orders", :hash, "order_set", encoded)
        end)

      {:error, error} ->
        handle_error_response(conn, error)
    end
  end

  defp handle_error_response(conn, error) do
    conn
    |> put_status(401)
    |> put_view(MainWeb.ErrorView)
    |> render("401.json", %{error: error})
    |> halt()
  end

  defp get_token(conn) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] -> {:ok, token}
      ["bearer " <> token] -> {:ok, token}
      [] -> {:error, :missing_token}
      ["Bearer"] -> {:error, :invalid_token}
      _ -> {:error, :invalid_token}
    end
  end

  defp get_sub(conn) do
    case get_req_header(conn, "sub") do
      [sub] -> sub
    end
  end
end
