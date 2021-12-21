defmodule ZashiHRWeb.Graphql.Types.Posts do
  use Absinthe.Schema.Notation
  alias ZashiHRWeb.Graphql.Resolvers.Posts, as: PostResolvers
  alias ZashiHR.Middlewares.Authorize, as: AuthorizeMiddleware
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  @desc "Post"
  object :post do
    field :id, :id, description: "post unique identifier"
    field :title, :string, description: "post title"
    field :description, :string, description: "post description"
    field :logo, :string, description: "post image"
    field :location, :string, description: "post image"
    field :salary_base, :integer, description: "post base salary"
    field :salary_up_to, :integer, description: "post max salary"
    field :salary_frequency, :salary_frequency, description: "post salary frequency"
    field :job_type, list_of(:job_types), description: "post job type (partime - fulltime - intern)"
    field :labels, list_of(:string), description: "post labels to be identified"
    field :vacants, :integer, description: "post number of vacants"
    field :inserted_at, :string, description: "time that post was inserted"
    field :company_id, :integer, description: "company owner id"
    field :company, :company, resolve: dataloader(:company)
  end

  @desc "post info to be created"
  input_object :create_post_params, description: "Create post" do
    field :title, non_null(:string), description: "post title"
    field :description, non_null(:string), description: "post description"
    field :logo, :string, description: "post image"
    field :location, :string, description: "post image"
    field :salary_base, :integer, description: "post base salary"
    field :salary_up_to, :integer, description: "post max salary"
    field :salary_frequency, :salary_frequency, description: "post salary frequency"
    field :job_type, non_null(list_of(:job_types)), description: "post job type (partime - fulltime - intern)"
    field :labels, list_of(:string), description: "post labels to be identified"
    field :vacants, :integer, description: "post number of vacants"
  end

  @desc "post filter"
  input_object :post_filters, description: "post filter input" do
    field :id, :filter_operators, description: "post title"
    field :title, :filter_operators, description: "post title"
    field :description, :filter_operators, description: "post description"
    field :logo, :filter_operators, description: "post image"
    field :location, :filter_operators, description: "post image"
    field :salary_base, :filter_operators, description: "post base salary"
    field :salary_up_to, :filter_operators, description: "post max salary"
    field :salary_frequency, :filter_operators, description: "post salary frequency"
    field :job_type, :filter_operators, description: "post job type (partime - fulltime - intern)"
    field :labels, :filter_operators, description: "post labels to be identified"
    field :vacants, :filter_operators, description: "post number of vacants"
    field :inserted_at, :filter_operators, description: "time that post was inserted"
    field :company_id, :filter_operators, description: "company owner id"

    field :or, list_of(:post_filters)
  end

  @desc "post order"
  input_object :post_order, description: "post sorting input" do
    field :id, :order_by_operators, description: "post title"
    field :salary_base, :order_by_operators, description: "post base salary"
    field :salary_up_to, :order_by_operators, description: "post max salary"
    field :vacants, :order_by_operators, description: "post number of vacants"
    field :inserted_at, :order_by_operators, description: "time that post was inserted"
  end

  # QUERIES
  object :post_queries do
    @desc "Get all the posts"
    field :posts, list_of(:post) do
      arg :order_by, :post_order
      arg :filter, :post_filters
      arg :pagination, :pagination_input

      resolve &PostResolvers.list/3
    end

    @desc "Get post by id"
    field :post_by_id, :post do
      arg(:id, non_null(:id))
      resolve(&PostResolvers.by_id/2)
    end
  end

  # MUTATIONS
  object :post_mutations do
    @desc "Create new Post"
    field :create_post, type: :post do
      arg(:post, :create_post_params)

      middleware(AuthorizeMiddleware, [:employer, :admin])
      resolve(&PostResolvers.create/2)
    end
  end
end
