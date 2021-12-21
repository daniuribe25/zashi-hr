defmodule ZashiHR.Repo.Migrations.CreateUserTimeOffHistory do
  use Ecto.Migration

  def change do
    create table(:user_timeoff_history) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :timeoff, references(:time_off_types, on_delete: :delete_all), null: false
      add :date, :naive_datetime, null: false
      add :description, :string
      add :used, :integer
      add :added, :integer
      add :balance, :integer
      add :active, :boolean, default: true, null: false

      timestamps()
    end

    create index(:user_timeoff_history, [:user_id])
  end
end
