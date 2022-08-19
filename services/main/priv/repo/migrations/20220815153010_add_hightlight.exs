defmodule Main.Repo.Migrations.AddHightlight do
  use Ecto.Migration

  def change do
    alter table("products") do
      add :hightlight, :boolean
    end
  end
end
