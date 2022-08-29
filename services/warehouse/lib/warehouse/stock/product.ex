defmodule Warehouse.Stock.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @derive Jason.Encoder
  schema "products" do
    field :product_id, :integer
    field :amount, :integer

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:product_id, :amount])
    |> validate_required([:product_id, :amount])
  end
end
