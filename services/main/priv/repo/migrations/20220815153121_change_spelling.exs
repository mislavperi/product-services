defmodule Main.Repo.Migrations.ChangeSpelling do
  use Ecto.Migration

  def change do
    alter table("products") do
      remove :hightlight
      add :highlight, :boolean
    end
  end
end
