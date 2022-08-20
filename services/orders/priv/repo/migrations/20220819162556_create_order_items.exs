defmodule Orders.Repo.Migrations.CreateOrderItems do
  use Ecto.Migration

  def change do
    create table(:order_items) do
      add :order_id, :integer
      add :order_item, :string

      timestamps()
    end
  end
end
