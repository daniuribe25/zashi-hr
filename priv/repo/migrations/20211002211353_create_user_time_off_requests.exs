defmodule ZashiHR.Repo.Migrations.CreateUserTimeOffRequest do
  use Ecto.Migration

  def change do
    create table(:user_time_off_requests) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :timeoff, references(:time_off_types, on_delete: :delete_all), null: false
      add :from, :naive_datetime, null: false
      add :to, :naive_datetime, null: false
      add :note, :string
      add :status, :string, default: "requested", null: false

      timestamps()
    end

    create index(:user_time_off_requests, [:user_id])
  end
end
