defmodule ZashiHR.Repo.Migrations.CreateUserAddresses do
  use Ecto.Migration

  def change do
    create table(:user_addresses) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :main, :string, null: false
      add :secondary, :string
      add :city, :string, null: false
      add :state, :string, null: false
      add :zip_code, :string
      add :country, :string, null: false

      timestamps()
    end

    create index(:user_addresses, [:user_id])
  end
end
