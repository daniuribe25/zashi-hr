defmodule ZashiHRWeb.Graphql.Types.UserEducation do
  use Absinthe.Schema.Notation
  alias ZashiHRWeb.Graphql.Resolvers.UserEducation, as: UserEducationResolvers
  alias ZashiHR.Middlewares.Authorize, as: AuthorizeMiddleware
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  @desc "User Education"
  object :user_education do
    field :id, :id, description: "user_education unique identifier"
    field :title, :string, description: "user education position"
    field :institution, :string, description: "user education company"
    field :from, :date, description: "user education from date"
    field :to, :date, description: "user education to date"
    field :user_id, :integer, description: "user owner id"
    field :user, :user, resolve: dataloader(:user)
    field :inserted_at, :string, description: "time that user education was inserted"
  end

  @desc "user education info to be created"
  input_object :create_user_education_params, description: "Create user education" do
    field :title, :string, description: "user education title"
    field :institution, :string, description: "user education institution"
    field :from, :date, description: "user education from date"
    field :to, :date, description: "user education to date"
  end

  @desc "user education filter"
  input_object :user_education_filters, description: "user_education filter input" do
    field :id, :filter_operators, description: "user education unique identifier"
    field :title, :filter_operators, description: "user education title"
    field :institution, :filter_operators, description: "user education institution"
    field :from, :filter_operators, description: "user education from date"
    field :to, :filter_operators, description: "user education to date"
    field :user_id, :filter_operators, description: "user owner id"

    field :or, list_of(:user_education_filters)
  end

  @desc "user education order"
  input_object :user_education_order, description: "user education sorting input" do
    field :id, :order_by_operators, description: "user education title"
    field :title, :order_by_operators, description: "user education base salary"
    field :institution, :order_by_operators, description: "user education max salary"
    field :from, :order_by_operators, description: "user education number of vacants"
    field :to, :order_by_operators, description: "user education number of vacants"
    field :inserted_at, :order_by_operators, description: "time that user education was inserted"
  end

  # QUERIES
  object :user_education_queries do
    @desc "Get all the user educations"
    field :user_educations, list_of(:user_education) do
      arg :filter, :user_education_filters
      arg :order_by, :user_education_order
      arg :pagination, :pagination_input

      middleware(AuthorizeMiddleware, [:employer, :admin, :seeker])
      resolve &UserEducationResolvers.list/3
    end

    @desc "Get user education by id"
    field :user_education_by_id, :user_education do
      arg(:id, non_null(:id))

      middleware(AuthorizeMiddleware, [:employer, :admin, :seeker])
      resolve(&UserEducationResolvers.by_id/2)
    end
  end

  # MUTATIONS
  object :user_education_mutations do
    @desc "Create new User Work Education"
    field :create_user_education, type: :user_education do
      arg(:user_education, :create_user_education_params)

      middleware(AuthorizeMiddleware, [:seeker, :admin])
      resolve(&UserEducationResolvers.create/2)
    end
  end
end
