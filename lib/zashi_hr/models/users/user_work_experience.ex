defmodule ZashiHR.Models.Users.UserWorkExperience do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_work_experiences" do
    field :active, :boolean, default: true
    field :company, :string
    field :description, :string
    field :from, :date
    field :to, :date
    field :position, :string

    belongs_to :user, ZashiHR.Models.Users.User

    timestamps()
  end

  @doc false
  def changeset(user_work_experience, attrs) do
    user_work_experience
    |> cast(attrs, [:position, :company, :from, :to, :description])
    |> validate_required([:position, :company, :from, :to, :description])
  end
end
