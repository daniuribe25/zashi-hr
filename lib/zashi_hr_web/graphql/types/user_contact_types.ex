defmodule ZashiHRWeb.Graphql.Types.UserContact do
  use Absinthe.Schema.Notation
  alias ZashiHRWeb.Graphql.Resolvers.UserContact, as: UserContactResolvers
  alias ZashiHR.Middlewares.Authorize, as: AuthorizeMiddleware
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  @desc "User Contact"
  object :user_contact do
    field :id, :id, description: "user contact unique identifier"
    field :work_phone, :string, description: "user work phone"
    field :mobile_phone, :string, description: "user mobile phone"
    field :home_phone, :string, description: "user home phone"
    field :personal_email, :string, description: "user personal email"
    field :linkedin, :string, description: "user linkedin"
    field :twitter, :string, description: "user twitter"
    field :facebook, :string, description: "user facebook"
    field :user, :user, resolve: dataloader(:user)
    field :inserted_at, :string, description: "time that user contact was inserted"
  end

  @desc "user contact info to be created"
  input_object :update_user_contact_params, description: "Update user contact" do
    field :work_phone, :string, description: "user work phone"
    field :mobile_phone, :string, description: "user mobile phone"
    field :home_phone, :string, description: "user home phone"
    field :personal_email, :string, description: "user personal email"
    field :linkedin, :string, description: "user linkedin"
    field :twitter, :string, description: "user twitter"
    field :facebook, :string, description: "user facebook"
  end

  # QUERIES
  object :user_contact_queries do
    @desc "Get user contact information"
    field :user_contact, :user_contact do
      middleware(AuthorizeMiddleware, [:common])
      resolve(&UserContactResolvers.get/3)
    end
  end

  # MUTATIONS
  object :user_contact_mutations do
    @desc "Update User Contact"
    field :update_user_contact, type: :user_contact do
      arg(:user_contact, :update_user_contact_params)

      middleware(AuthorizeMiddleware, [:common])
      resolve(&UserContactResolvers.create_or_update/2)
    end
  end
end
