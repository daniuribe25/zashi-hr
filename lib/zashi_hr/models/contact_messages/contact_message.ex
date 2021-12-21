defmodule ZashiHR.Models.ContactMessages.ContactMessage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contact_messages" do
    field :email, :string
    field :fullname, :string
    field :message, :string
    field :phone, :string

    timestamps()
  end

  @doc false
  def changeset(contact_message, attrs) do
    contact_message
    |> cast(attrs, [:fullname, :email, :phone, :message])
    |> validate_required([:fullname, :email, :phone, :message])
  end
end
