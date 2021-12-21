defmodule ZashiHR.Repo.Migrations.CreatePositions do
  use Ecto.Migration

  def change do
    create table(:positions) do
      add :name, :string
      add :description, :text
      add :active, :boolean, default: true, null: false

      timestamps()
    end

    create unique_index(:positions, [:name], name: "positions_unique_name_index")
  end
end
