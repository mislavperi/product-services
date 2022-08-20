defmodule Orders.Repo.Migrations.AddFkKey do
  use Ecto.Migration

  def change do
    drop_if_exists index(:order_items, [:order_id])
    alter table("order_items") do
      modify :order_id, references(:orders, on_delete: :delete_all)
    end
  end
end
