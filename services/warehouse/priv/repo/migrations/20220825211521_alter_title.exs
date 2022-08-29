defmodule Warehouse.Repo.Migrations.AlterTitle do
  use Ecto.Migration

  def change do
    alter table ("products") do
      add :product_id, :integer
      remove :title
    end
  end
end
