defmodule ZashiHRWeb.Graphql.Types.Companies do
  use Absinthe.Schema.Notation
  alias ZashiHRWeb.Graphql.Resolvers.Companies, as: CompanyResolvers
  alias ZashiHR.Middlewares.Authorize, as: AuthorizeMiddleware

  # TYPES
  @desc "Platform company definition"
  object :company do
    field :id, :id, description: "company unique identifier"
    field :name, :string, description: "company name"
    field :phone, :string, description: "company phone"
    field :email, :string, description: "company email"
    field :logo, :string, description: "company logo"
    field :website, :string, description: "company website"
    field :description, :string, description: "company description"
    field :role, :string, description: "company role"
    field :post_credits, :integer, description: "company credits to create posts"
    field :inserted_at, :string, description: "time that company was inserted"
  end

  @desc "Company info to be created"
  input_object :create_company_params, description: "Create company" do
    field :name, non_null(:string), description: "company name"
    field :email, non_null(:string), description: "company email"
    field :password, non_null(:string), description: "company password with regex validation"
    field :password_confirmation, non_null(:string), description: "optional company password confirmation with regex validation"
    field :phone, :string, description: "optional company phone"
    field :logo, :string, description: "company logo"
    field :website, :string, description: "company website"
    field :description, :string, description: "company description"
    field :accept_terms, non_null(:boolean), description: "company accepts terms and conditions"
  end

  @desc "company filter"
  input_object :company_filters, description: "company filter input" do
    field :name, :filter_operators, description: "company name"
    field :email, :filter_operators, description: "company email"
    field :phone, :filter_operators, description: "company phone"
    field :role, :filter_operators, description: "company role"
    field :description, :filter_operators, description: "company description"

    field :or, list_of(:company_filters)
  end

  @desc "company order"
  input_object :company_order, description: "company sorting input" do
    field :id, :order_by_operators, description: "company id"
    field :name, :order_by_operators, description: "company fullname"
    field :email, :order_by_operators, description: "company email"
    field :phone, :order_by_operators, description: "company phone"
    field :inserted_at, :order_by_operators, description: "time that company was inserted"
  end

  # QUERIES
  object :company_queries do
    @desc "Get all Companies"
    field :companies, list_of(:company) do
      arg :filter, :company_filters
      arg :order_by, :company_order
      arg :pagination, :pagination_input

      resolve(&CompanyResolvers.list/3)
    end

    @desc "Get Company by id"
    field :company_by_id, :company do
      arg(:id, non_null(:id))

      middleware(AuthorizeMiddleware, [:employer, :admin])
      resolve(&CompanyResolvers.by_id/2)
    end
  end

  # MUTATIONS
  object :company_mutations do
    @desc "Create new Company"
    field :create_company, type: :company do
      arg(:company, :create_company_params)

      resolve(&CompanyResolvers.create/2)
    end

    @desc "Add company post credits"
    field :add_post_credits, type: :company do
      arg :credits, non_null(:integer)

      middleware(AuthorizeMiddleware, [:employer])
      resolve(&CompanyResolvers.add_post_credits/2)
    end
  end
end
