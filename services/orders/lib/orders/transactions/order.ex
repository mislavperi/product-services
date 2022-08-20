defmodule Orders.Transactions.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :account, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:account, :status])
    |> validate_required([:account, :status])
  end
end
