defmodule ZashiHRWeb.Graphql.Types.UserAddress do
  use Absinthe.Schema.Notation
  alias ZashiHRWeb.Graphql.Resolvers.UserAddress, as: UserAddressResolvers
  alias ZashiHR.Middlewares.Authorize, as: AuthorizeMiddleware
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  @desc "User Address"
  object :user_address do
    field :id, :id, description: "user_address unique identifier"
    field :main, :string, description: "user address main"
    field :secondary, :string, description: "user address secondary"
    field :city, :string, description: "user address city"
    field :state, :string, description: "user address state"
    field :zip_code, :string, description: "user address zip code"
    field :country, :string, description: "user address country"
    field :user_id, :integer, description: "user owner id"
    field :user, :user, resolve: dataloader(:user)
    field :inserted_at, :string, description: "time that user address was inserted"
  end

  @desc "user address info to be created"
  input_object :create_user_address_params, description: "Create user address" do
    field :main, non_null(:string), description: "user address main"
    field :secondary, :string, description: "user address secondary"
    field :city, non_null(:string), description: "user address city"
    field :state, non_null(:string), description: "user address state"
    field :zip_code, :string, description: "user address zip code"
    field :country, non_null(:string), description: "user address country"
  end

  @desc "user address info to be created"
  input_object :update_user_address_params, description: "Update user address" do
    field :main, :string, description: "user address main"
    field :secondary, :string, description: "user address secondary"
    field :city, :string, description: "user address city"
    field :state, :string, description: "user address state"
    field :zip_code, :string, description: "user address zip code"
    field :country, :string, description: "user address country"
  end

  @desc "user address filter"
  input_object :user_address_filters, description: "user_address filter input" do
    field :id, :filter_operators, description: "user address unique identifier"
    field :city, :filter_operators, description: "user address from city"
    field :state, :filter_operators, description: "user address to state"
    field :zip_code, :filter_operators, description: "user address from zip_code"
    field :country, :filter_operators, description: "user address to country"
    field :user_id, :filter_operators, description: "user owner id"

    field :or, list_of(:user_address_filters)
  end

  @desc "user address order"
  input_object :user_address_order, description: "user address sorting input" do
    field :id, :order_by_operators, description: "user address id"
    field :inserted_at, :order_by_operators, description: "time that user address was inserted"
  end

  # QUERIES
  object :user_address_queries do
    @desc "Get all the user addresss"
    field :list_user_addresses, list_of(:user_address) do
      arg :filter, :user_address_filters
      arg :order_by, :user_address_order
      arg :pagination, :pagination_input

      middleware(AuthorizeMiddleware, [:admin])
      resolve &UserAddressResolvers.list/3
    end

    @desc "Get all the user addresss"
    field :user_address, :user_address do
      middleware(AuthorizeMiddleware, [:common])
      resolve &UserAddressResolvers.get/3
    end
  end

  # MUTATIONS
  object :user_address_mutations do
    @desc "Create new User Address"
    field :create_user_address, type: :user_address do
      arg(:user_address, :create_user_address_params)

      middleware(AuthorizeMiddleware, [:common])
      resolve(&UserAddressResolvers.create/2)
    end

    @desc "Update User Address"
    field :update_user_address, type: :user_address do
      arg(:user_address, :update_user_address_params)

      middleware(AuthorizeMiddleware, [:common])
      resolve(&UserAddressResolvers.update/2)
    end
  end
end
