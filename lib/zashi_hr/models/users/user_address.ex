defmodule ZashiHR.Models.Users.UserAddress do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_addresses" do
    field :main, :string
    field :secondary, :string
    field :city, :string
    field :state, :string
    field :zip_code, :string
    field :country, :string
    belongs_to :user, ZashiHR.Models.Users.User

    timestamps()
  end

  @doc false
  def changeset(user_address, attrs) do
    user_address
    |> cast(attrs, [:main, :secondary, :city, :state, :zip_code, :country])
    |> validate_required([:main, :city, :state, :country])
  end
end
