defmodule Warehouse.Repo.Migrations.UpdateStock do
  use Ecto.Migration

  def change do
    alter table ("products") do
      add :amount, :integer
    end
  end
end
