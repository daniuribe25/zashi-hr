defmodule ZashiHR.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string
      add :hire_date, :date
      add :position, :string, null: false
      add :birth_date, :date
      add :gender, :string
      add :marital_status, :string
      add :role, :string, default: "common"
      add :active, :boolean, default: true, null: false
      add :last_invitation_at, :naive_datetime, default: fragment("now()")

      timestamps()
    end

    create unique_index(:users, [:email], name: "users_unique_email_index")
  end
end
