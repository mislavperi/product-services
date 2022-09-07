defmodule MainWeb.Warehouse do
  alias Req

  def reserve_stock(params) do
    req = Req.new(url: "/api/v1/stock/reserve")
    req = Req.Request.put_header(req, "apikey", "7B5zIqmRGXmrJTFmKa99vcit")
    %Req.Response{body: body, headers: headers, private: private, status: status} =
      Req.post!(req, json: params)

    case status do
      200 -> :ok
      status when status != 200 -> :error
    end
  end
end
