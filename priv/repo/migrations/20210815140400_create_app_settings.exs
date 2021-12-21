defmodule ZashiHR.Repo.Migrations.CreateAppSettings do
  use Ecto.Migration

  def change do
    create table(:app_settings) do
      add :name, :string, null: false
      add :value, :string, null: false
      add :description, :text
      add :active, :boolean, default: true, null: false

      timestamps()
    end

    create unique_index(:app_settings, [:name], name: "app_settings_unique_name_index")
  end
end
