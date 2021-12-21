defmodule ZashiHRWeb.Graphql.Types.UserExperiences do
  use Absinthe.Schema.Notation
  alias ZashiHRWeb.Graphql.Resolvers.UserExperiences, as: UserExperienceResolvers
  alias ZashiHR.Middlewares.Authorize, as: AuthorizeMiddleware
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  @desc "User Experience"
  object :user_experience do
    field :id, :id, description: "user experience unique identifier"
    field :position, :string, description: "user experience position"
    field :company, :string, description: "user experience company"
    field :from, :date, description: "user_experience from date"
    field :to, :date, description: "user experience to date"
    field :description, :string, description: "user experience description"
    field :user_id, :integer, description: "user owner id"
    field :user, :user, resolve: dataloader(:user)
    field :inserted_at, :string, description: "time that user_experience was inserted"
  end

  @desc "user experience info to be created"
  input_object :create_user_experience_params, description: "Create user experience" do
    field :position, :string, description: "user experience position"
    field :company, :string, description: "user experience company"
    field :from, :date, description: "user experience from date"
    field :to, :date, description: "user experience to date"
    field :description, :string, description: "user experience description"
  end

  @desc "user_experience filter"
  input_object :user_experience_filters, description: "user_experience filter input" do
    field :id, :filter_operators, description: "user experience unique identifier"
    field :position, :filter_operators, description: "user experience position"
    field :company, :filter_operators, description: "user experience company"
    field :from, :filter_operators, description: "user experience from date"
    field :to, :filter_operators, description: "user experience to date"
    field :description, :filter_operators, description: "user experience description"
    field :user_id, :filter_operators, description: "user owner id"

    field :or, list_of(:user_experience_filters)
  end

  @desc "user experience order"
  input_object :user_experience_order, description: "user experience sorting input" do
    field :id, :order_by_operators, description: "user experience title"
    field :position, :order_by_operators, description: "user experience position"
    field :company, :order_by_operators, description: "user experience company"
    field :from, :order_by_operators, description: "user experience from date"
    field :to, :order_by_operators, description: "user experience to"
    field :user_id, :order_by_operators, description: "user owner id"
    field :inserted_at, :order_by_operators, description: "time that user experience was inserted"
  end

  # QUERIES
  object :user_experience_queries do
    @desc "Get all the user experiences"
    field :user_experiences, list_of(:user_experience) do
      arg :filter, :user_experience_filters
      arg :order_by, :user_experience_order
      arg :pagination, :pagination_input

      middleware(AuthorizeMiddleware, [:employer, :admin, :seeker])
      resolve &UserExperienceResolvers.list/3
    end

    @desc "Get user experience by id"
    field :user_experience_by_id, :user_experience do
      arg(:id, non_null(:id))

      middleware(AuthorizeMiddleware, [:employer, :admin, :seeker])
      resolve(&UserExperienceResolvers.by_id/2)
    end
  end

  # MUTATIONS
  object :user_experience_mutations do
    @desc "Create new User Work Experience"
    field :create_user_experience, type: :user_experience do
      arg(:user_experience, :create_user_experience_params)

      middleware(AuthorizeMiddleware, [:seeker, :admin])
      resolve(&UserExperienceResolvers.create/2)
    end
  end
end
