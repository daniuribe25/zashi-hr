defmodule ZashiHR.Repo.Migrations.UpdateAppSettingsTable do
  use Ecto.Migration

  def change do
    alter table(:app_settings) do
      add :type, :string, null: false, default: "string"
    end
  end
end
