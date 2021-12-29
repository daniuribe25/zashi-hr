defmodule ZashiHR.Models.Users.UserEducation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_educations" do
    field :degree, :string
    field :institution, :string
    field :from, :date
    field :to, :date
    belongs_to :user, ZashiHR.Models.Users.User

    timestamps()
  end

  @doc false
  def changeset(user_education, attrs) do
    user_education
    |> cast(attrs, [:degree, :institution, :from, :to])
    |> validate_required([:degree, :institution, :from, :to])
  end
end
