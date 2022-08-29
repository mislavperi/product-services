defmodule Orders.Repo.Migrations.AddAmount do
  use Ecto.Migration

  def change do
    alter table("order_items") do
      add :amount, :integer
      remove :order_item
      add :order_item, :integer
    end
  end
end
