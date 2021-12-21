defmodule ZashiHRWeb.Graphql.Types.Resumes do
  use Absinthe.Schema.Notation
  alias ZashiHRWeb.Graphql.Resolvers.Resumes, as: ResumeResolvers
  alias ZashiHR.Middlewares.Authorize, as: AuthorizeMiddleware
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  @desc "Resume"
  object :resume do
    field :id, :id, description: "resume unique identifier"
    field :resume_url, :string, description: "resume url"
    field :photo_url, :string, description: "resume user photo"
    field :category, list_of(:string), description: "resume user job category"
    field :job_type, list_of(:job_types), description: "resume job type (partime - fulltime - intern)"
    field :summary, :string, description: "resume summary"
    field :city, :string, description: "resume user city"
    field :country, :string, description: "resume user country"
    field :desired_salary, :integer, description: "user desired salary"
    field :desired_job_title, :string, description: "user desired job title"
    field :user_id, :integer, description: "company owner id"
    field :user, :user, resolve: dataloader(:user)
    field :inserted_at, :string, description: "time that resume was inserted"
  end

  @desc "resume info to be created"
  input_object :create_resume_params, description: "Create resume" do
    field :resume_url, :string, description: "resume url"
    field :photo_url, :string, description: "resume user photo"
    field :job_type, list_of(:job_types), description: "resume job type (partime - fulltime - intern)"
    field :summary, :string, description: "resume summary"
    field :category, list_of(:string), description: "resume user job categories"
    field :city, :string, description: "resume user city"
    field :country, :string, description: "resume user country"
    field :desired_salary, :integer, description: "user desired salary"
    field :desired_job_title, :string, description: "user desired job title"
    field :inserted_at, :string, description: "time that resume was inserted"
  end

  @desc "resume filter"
  input_object :resume_filters, description: "resume filter input" do
    field :resume_url, :filter_operators, description: "resume url"
    field :photo_url, :filter_operators, description: "resume user photo"
    field :job_type, :filter_operators, description: "resume job type (partime - fulltime - intern)"
    field :summary, :filter_operators, description: "resume summary"
    field :category, :filter_operators, description: "resume user job categories"
    field :city, :filter_operators, description: "resume user city"
    field :country, :filter_operators, description: "resume user country"
    field :desired_salary, :filter_operators, description: "user desired salary"
    field :desired_job_title, :filter_operators, description: "user desired job title"
    field :user_id, :filter_operators, description: "user resumes"
    field :inserted_at, :string, description: "time that resume was inserted"

    field :or, list_of(:resume_filters)
  end

  @desc "resumes order"
  input_object :resumes_order, description: "resumes sorting input" do
    field :id, :order_by_operators, description: "resume id"
    field :desired_salary, :order_by_operators, description: "desired salary"
    field :inserted_at, :order_by_operators, description: "time that resume was inserted"
  end

  # QUERIES
  object :resume_queries do
    @desc "Get all the resumes"
    field :resumes, list_of(:resume) do
      arg :filter, :resume_filters
      arg :order_by, :resumes_order
      arg :pagination, :pagination_input

      middleware(AuthorizeMiddleware, [:employer, :admin, :seeker])
      resolve &ResumeResolvers.list/3
    end

    @desc "Get resume by id"
    field :resume_by_id, :resume do
      arg(:id, non_null(:id))

      middleware(AuthorizeMiddleware, [:employer, :admin, :seeker])
      resolve(&ResumeResolvers.by_id/2)
    end
  end

  # MUTATIONS
  object :resume_mutations do
    @desc "Create new Resume"
    field :create_resume, type: :resume do
      arg(:resume, :create_resume_params)

      middleware(AuthorizeMiddleware, [:seeker, :admin])
      resolve(&ResumeResolvers.create/2)
    end
  end
end
