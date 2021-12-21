defmodule ZashiHRWeb.Graphql.Types.AdminUsers do
  use Absinthe.Schema.Notation
  alias ZashiHRWeb.Graphql.Resolvers.Users, as: UserResolvers
  alias ZashiHR.Middlewares.Authorize, as: AuthorizeMiddleware

  # TYPES
  @desc "Platform admin user definition"
  object :admin_user do
    field :id, :id, description: "user unique identifier"
    field :first_name, :string, description: "user first name"
    field :last_name, :string, description: "user last name"
    field :email, :string, description: "user email"
    field :role, :string, description: "user role"
    field :inserted_at, :string, description: "time that user was inserted"
  end

  @desc "User info to be created"
  input_object :create_admin_user_params, description: "Create user" do
    field :email, non_null(:string), description: "user email"
    field :password, non_null(:string), description: "user password"
    field :first_name, non_null(:string), description: "user first name"
    field :last_name, non_null(:string), description: "user last name"
  end

  @desc "Assign password from invitation"
  input_object :set_admin_user_password_params, description: "Set User password from invitation" do
    field :password, non_null(:string), description: "user password"
    field :confirm_password, non_null(:string), description: "user confirm password"
  end

  @desc "Update user info"
  input_object :update_admin_user_params, description: "Create user" do
    field :first_name, non_null(:string), description: "user first name"
    field :last_name, non_null(:string), description: "user last name"
    field :email, non_null(:string), description: "user email"
    field :hire_date, non_null(:date), description: "user hire date on the company"
    field :position, non_null(:string), description: "user position"
    field :birth_date, :date, description: "user birth date"
    field :gender, :string, description: "user gender"
  end

  @desc "user filter"
  input_object :admin_user_filters, description: "user filter input" do
    field :first_name, :filter_operators, description: "user first name"
    field :last_name, :filter_operators, description: "user last name"
    field :email, :filter_operators, description: "user email"
    field :hire_date, :filter_operators, description: "user hire date"
    field :birth_date, :filter_operators, description: "user birth date"
    field :gender, :filter_operators, description: "user gender"
    field :position, :filter_operators, description: "user position"
    field :inserted_at, :filter_operators, description: "user inserted at certain time"

    field :or, list_of(:user_filters)
  end

  @desc "user order"
  input_object :admin_user_order, description: "user sorting input" do
    field :id, :order_by_operators, description: "user id"
    field :first_name, :order_by_operators, description: "user first name"
    field :last_name, :order_by_operators, description: "user last name"
    field :hire_date, :order_by_operators, description: "user hire date"
    field :inserted_at, :order_by_operators, description: "time that user was inserted"
  end

  # QUERIES
  object :admin_user_queries do
    @desc "Get all the users"
    field :admin_users, list_of(:admin_user) do
      arg :filter, :user_filters
      arg :order_by, :user_order
      arg :pagination, :pagination_input

      # middleware(AuthorizeMiddleware, [:admin])
      resolve(&UserResolvers.list/3)
    end

  end

  # MUTATIONS
  object :admin_user_mutations do
    @desc "Create new Admin User"
    field :create_admin_user, type: :admin_user do
      arg(:user, :create_admin_user_params)

      resolve(&UserResolvers.create/2)
    end
  end
end
