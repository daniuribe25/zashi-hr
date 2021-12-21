defmodule ZashiHR.Repo.Migrations.CreateUserEducations do
  use Ecto.Migration

  def change do
    create table(:user_educations) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :degree, :string, null: false
      add :institution, :string, null: false
      add :from, :date, null: false
      add :to, :date, null: false

      timestamps()
    end

    create index(:user_educations, [:user_id])
  end
end
