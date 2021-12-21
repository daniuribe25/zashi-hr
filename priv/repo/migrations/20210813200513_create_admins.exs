defmodule ZashiHR.Repo.Migrations.CreateAdminUsers do
  use Ecto.Migration

  def change do
    create table(:admin_users) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string
      add :role, :string, default: "admin"
      add :active, :boolean, default: true, null: false

      timestamps()
    end

    create unique_index(:admin_users, [:email], name: "admin_users_unique_email_index")
  end
end
