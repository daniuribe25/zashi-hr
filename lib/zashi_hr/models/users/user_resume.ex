defmodule ZashiHR.Models.Users.UserResume do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_resumes" do
    field :category, {:array, :string}
    field :city, :string
    field :country, :string
    field :desired_job_title, :string
    field :desired_salary, :integer
    field :job_type, {:array, :string}, default: ["FULLTIME"]
    field :photo_url, :string
    field :resume_url, :string
    field :summary, :string
    field :active, :boolean, default: true

    belongs_to :user, ZashiHR.Models.Users.User

    timestamps()
  end

  @doc false
  def changeset(user_resume, attrs) do
    user_resume
    |> cast(attrs, [:resume_url, :photo_url, :job_type, :category, :summary, :city, :country, :desired_salary, :desired_job_title])
    |> validate_required([:job_type, :category, :summary, :desired_salary, :desired_job_title])
  end
end
