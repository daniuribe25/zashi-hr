defmodule ZashiHR.Models.Settings.AppSettings do
  use Ecto.Schema
  import Ecto.Changeset

  schema "app_settings" do
    field :name, :string
    field :value, :string
    field :type, :string
    field :description, :string
    field :active, :boolean, default: true

    timestamps()
  end

  @doc false
  def changeset(settings, attrs) do
    settings
    |> cast(attrs, [:name, :value, :description])
    |> validate_required([:name, :value], message: "is required")
  end
end
