defmodule ZashiHRWeb.Graphql.Types.AppSettings do
  use Absinthe.Schema.Notation
  alias ZashiHRWeb.Graphql.Resolvers.AppSettings, as: AppSettingsResolvers
  alias ZashiHR.Middlewares.Authorize, as: AuthorizeMiddleware

  @desc "App Settings"
  object :app_settings do
    field :id, :id, description: "app settings unique identifier"
    field :name, :string, description: "app settings name"
    field :value, :string, description: "app settings value"
    field :description, :string, description: "app settings description"
  end

  @desc "App settings input params"
  input_object :app_settings_params, description: "app settings params input" do
    field :id, non_null(:id), description: "app settings identifier"
    field :value, non_null(:string), description: "app settings value"
  end

  @desc "App settings filter"
  input_object :app_settings_filters, description: "app settings filter input" do
    field :name, :filter_operators, description: "app settings name"

    field :or, list_of(:app_settings_filters)
  end

  # QUERIES
  object :app_settings_queries do
    @desc "Get all app settings"
    field :app_settings, list_of(:app_settings) do
      arg :filter, :app_settings_filters

      resolve &AppSettingsResolvers.list/3
    end
  end

  # MUTATIONS
  object :app_settings_mutations do
    @desc "Update one of the app settings"
    field :update_app_settings, type: :app_settings do
      arg(:app_settings, non_null(:app_settings_params))

      middleware(AuthorizeMiddleware, [:admin, :super_admin])
      resolve &AppSettingsResolvers.update/2
    end
  end
end
