defmodule ZashiHR.Repo.Migrations.CreateTimeOffTypes do
  use Ecto.Migration

  def change do
    create table(:time_off_types) do
      add :name, :string, null: false
      add :description, :string
      add :active, :boolean, default: true, null: false

      timestamps()
    end
  end
end
