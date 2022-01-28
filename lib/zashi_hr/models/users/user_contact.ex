defmodule ZashiHR.Models.Users.UserContact do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_contacts" do
    field :work_phone, :string
    field :mobile_phone, :string
    field :home_phone, :string
    field :personal_email, :string
    field :linkedin, :string
    field :twitter, :string
    field :facebook, :string
    belongs_to :user, ZashiHR.Models.Users.User

    timestamps()
  end

  @doc false
  def changeset(user_contact, attrs) do
    user_contact
    |> cast(attrs, [:work_phone, :mobile_phone, :home_phone, :personal_email, :linkedin, :twitter, :facebook])
  end
end
