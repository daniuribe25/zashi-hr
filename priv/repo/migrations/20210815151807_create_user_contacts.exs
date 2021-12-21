defmodule ZashiHR.Repo.Migrations.CreateUserContacts do
  use Ecto.Migration

  def change do
    create table(:user_contacts) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :work_phone, :string
      add :mobile_phone, :string
      add :home_phone, :string
      add :personal_email, :string
      add :linkedin, :string
      add :twitter, :string
      add :facebook, :string

      timestamps()
    end

    create index(:user_contacts, [:user_id])
  end
end
