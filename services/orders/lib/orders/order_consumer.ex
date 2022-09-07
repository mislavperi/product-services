defmodule Orders.Consumer do
  import Jason

  alias Orders.Transactions
  alias Orders.Transactions.Order
  @behaviour :brod_group_subscriber_v2

  def child_spec(_arg) do
    config = %{
      client: :kafka_client,
      group_id: "consumer_group_name",
      topics: ["products.orders"],
      cb_module: __MODULE__,
      consumer_config: [{:begin_offset, :earliest}],
      init_data: [],
      message_type: :message_set,
      group_config: [
        offset_commit_policy: :commit_to_kafka_v2,
        offset_commit_interval_seconds: 5,
        rejoin_delay_seconds: 60,
        reconnect_cool_down_seconds: 60
      ]
    }

    %{
      id: __MODULE__,
      start: {:brod_group_subscriber_v2, :start_link, [config]},
      type: :worker,
      restart: :temporary,
      shutdown: 5000
    }
  end

  @impl :brod_group_subscriber_v2
  def init(_group_id, _init_data), do: {:ok, []}

  @impl :brod_group_subscriber_v2
  def handle_message(message, _state) do
    {_, _, _, _, message_data} = message

    Enum.each(message_data, fn msg ->
      {_, _, _, data, _, _, _} = msg
      decodedData = Jason.decode!(data)

      {:ok, order} =
        Transactions.create_order(%{
          account: decodedData["email"],
          status: "PROCESSING"
        })

      id = Map.get(order, :id)

      Transactions.create_order_items(%{
        order_id: id,
        order_item: decodedData["product_id"],
        amount: decodedData["amount"]
      })
    end)

    {:ok, :commit, []}
  end
end
