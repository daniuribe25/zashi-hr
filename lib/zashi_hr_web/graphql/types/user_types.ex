defmodule ZashiHRWeb.Graphql.Types.Users do
  use Absinthe.Schema.Notation
  alias ZashiHRWeb.Graphql.Resolvers.Users, as: UserResolvers
  alias ZashiHR.Middlewares.Authorize, as: AuthorizeMiddleware
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  # TYPES
  @desc "Platform user definition"
  object :user do
    field :id, :id, description: "user unique identifier"
    field :first_name, :string, description: "user first name"
    field :last_name, :string, description: "user last name"
    field :email, :string, description: "user email"
    field :hire_date, :date, description: "user hire date"
    field :position, :string, description: "user position"
    field :birth_date, :date, description: "user birth date"
    field :gender, :string, description: "user gender"
    field :marital_status, :string, description: "user marital status"
    field :inserted_at, :string, description: "time that user was inserted"
    field :user_contact, :user_contact, resolve: dataloader(:user_contact)
    field :user_address, :user_address, resolve: dataloader(:user_address)
  end

  @desc "User info to be created"
  input_object :create_user_params, description: "Create user" do
    field :first_name, non_null(:string), description: "user first name"
    field :last_name, non_null(:string), description: "user last name"
    field :email, non_null(:string), description: "user email"
    field :hire_date, non_null(:date), description: "user hire date on the company"
    field :position, non_null(:string), description: "user position"
    field :birth_date, :date, description: "user birth date"
    field :gender, :string, description: "user gender"
  end

  @desc "Assign password from invitation"
  input_object :set_user_password_params, description: "Set User password from invitation" do
    field :password, non_null(:string), description: "user password"
    field :confirm_password, non_null(:string), description: "user confirm password"
    field :token, non_null(:string), description: "token to identify valid invitation"
  end

  @desc "Update user info"
  input_object :update_user_params, description: "Update user parameters" do
    field :id, non_null(:id), description: "user first name"
    field :first_name, :string, description: "user first name"
    field :last_name, :string, description: "user last name"
    field :email, :string, description: "user email"
    field :hire_date, :date, description: "user hire date on the company"
    field :position, :string, description: "user position"
    field :birth_date, :date, description: "user birth date"
    field :gender, :string, description: "user gender"
    field :marital_status, :string, description: "user marital status"
  end

  @desc "user filter"
  input_object :user_filters, description: "user filter input" do
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
  input_object :user_order, description: "user sorting input" do
    field :id, :order_by_operators, description: "user id"
    field :first_name, :order_by_operators, description: "user first name"
    field :last_name, :order_by_operators, description: "user last name"
    field :hire_date, :order_by_operators, description: "user hire date"
    field :inserted_at, :order_by_operators, description: "time that user was inserted"
  end

  # QUERIES
  object :user_queries do
    @desc "Get all the users"
    field :users, list_of(:user) do
      arg :filter, :user_filters
      arg :order_by, :user_order
      arg :pagination, :pagination_input

      # middleware(AuthorizeMiddleware, [:admin])
      resolve(&UserResolvers.list/3)
    end

    @desc "Check if user invitation is still valid"
    field :is_user_invitation_valid, :boolean do
      arg(:token, non_null(:string))

      resolve(&UserResolvers.is_user_invitation_valid/2)
    end
  end

  # MUTATIONS
  object :user_mutations do
    @desc "Create new User"
    field :create_and_send_user_invitation, type: :user do
      arg(:user, :create_user_params)

      middleware(AuthorizeMiddleware, [:admin, :super_admin])
      resolve(&UserResolvers.create/2)
    end

    @desc "Assign password with invitation token"
    field :set_user_password, type: :user do
      arg(:user, :set_user_password_params)

      resolve(&UserResolvers.set_user_password/2)
    end

    @desc "Resend user invitation"
    field :send_user_invitation, type: :user do
      arg(:email, non_null(:string))

      middleware(AuthorizeMiddleware, [:admin, :super_admin])
      resolve(&UserResolvers.send_user_invitation/2)
    end

    @desc "Update user info"
    field :update_user, type: :user do
      arg(:user, :update_user_params)

      middleware(AuthorizeMiddleware, [:common, :admin, :super_admin])
      resolve(&UserResolvers.update/2)
    end
  end
end
