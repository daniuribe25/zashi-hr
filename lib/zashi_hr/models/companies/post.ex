defmodule ZashiHR.Models.Companies.Post do
  use Ecto.Schema
  import Ecto.Changeset
  # alias ZashiHRWeb.Graphql.Types.Custom.JobType

  schema "posts" do
    field :logo, :string
    field :title, :string
    field :salary_frequency, :string
    field :salary_base, :integer, default: 0
    field :salary_up_to, :integer, default: 0
    field :vacants, :integer, default: 1
    field :job_type, {:array, :string}, default: ["FULLTIME"]
    field :description, :string
    field :labels, {:array, :string}
    field :location, :string, default: "remote"
    field :active, :boolean, default: true

    belongs_to :company, ZashiHR.Models.Companies.Company

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :logo, :location, :salary_base, :salary_up_to, :salary_frequency, :job_type, :labels, :description, :vacants, :company_id])
    |> validate_required([:title, :location, :salary_base, :salary_up_to, :salary_frequency, :job_type, :labels, :description, :vacants, :company_id])
  end

end
