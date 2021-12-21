defmodule ZashiHR.Models.Users.UserEducation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_educations" do
    field :active, :boolean, default: true
    field :from, :date
    field :institution, :string
    field :title, :string
    field :to, :date
    belongs_to :user, ZashiHR.Models.Users.User

    timestamps()
  end

  @doc false
  def changeset(user_education, attrs) do
    user_education
    |> cast(attrs, [:title, :institution, :from, :to])
    |> validate_required([:title, :institution, :from, :to])
  end
end
