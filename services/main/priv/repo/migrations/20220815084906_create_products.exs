defmodule Main.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string
      add :description, :string
      add :price, :decimal

      timestamps()
    end
  end
end
