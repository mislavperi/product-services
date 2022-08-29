defmodule Main.Order do
  def send_order() do
    value = %{
      email: "mislavperic32@gmail.com",
      title: "Jacket",
      amount: 2,
    }
    encoded = Jason.encode!(value)
    :brod.produce_sync(:kafka_client, "products.orders", :hash, "product", encoded)
  end
end
