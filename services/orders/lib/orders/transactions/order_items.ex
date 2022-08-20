defmodule Orders.Transactions.OrderItems do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_items" do
    field :order_id, :integer
    field :order_item, :string

    timestamps()
  end

  @doc false
  def changeset(order_items, attrs) do
    order_items
    |> cast(attrs, [:order_id, :order_item])
    |> validate_required([:order_id, :order_item])
  end
end
