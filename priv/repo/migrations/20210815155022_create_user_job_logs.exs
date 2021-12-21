defmodule ZashiHR.Repo.Migrations.CreateUserJobLogs do
  use Ecto.Migration

  def change do
    create table(:user_job_logs) do
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :effective_date, :date
      add :location, :string
      add :department, :string
      add :job_title, :string
      add :reports_to, references(:users, on_delete: :nothing), null: false
      add :client, :string
      add :project, :string
      add :salary, :integer
      add :active, :boolean, default: true, null: false

      timestamps()
    end

    create index(:user_job_logs, [:user_id])
    create index(:user_job_logs, [:reports_to])
  end
end
