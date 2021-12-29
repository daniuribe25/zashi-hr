defmodule ZashiHRWeb.Schema do
  use Absinthe.Schema
  alias ZashiHR.Middlewares.ErrorHandler
  alias ZashiHR.Services.{Users, Companies, Posts}

  import_types(ZashiHRWeb.Graphql.Types)

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(:user, Users.data())
      |> Dataloader.add_source(:company, Companies.data())
      |> Dataloader.add_source(:post, Posts.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    import_fields(:session_queries)
    import_fields(:user_queries)
    import_fields(:admin_user_queries)
    import_fields(:company_queries)
    import_fields(:post_queries)
    import_fields(:resume_queries)
    import_fields(:user_address_queries)
    import_fields(:user_education_queries)
    import_fields(:app_settings_queries)
  end

  mutation do
    import_fields(:session_mutations)
    import_fields(:user_mutations)
    import_fields(:admin_user_mutations)
    import_fields(:company_mutations)
    import_fields(:post_mutations)
    import_fields(:resume_mutations)
    import_fields(:user_address_mutations)
    import_fields(:user_education_mutations)
    import_fields(:app_settings_mutations)
  end

  def middleware(middleware, _field, %{identifier: type}) when type in [:query, :mutation] do
    middleware ++ [ErrorHandler]
  end

  def middleware(middleware, _field, _object) do
    middleware
  end
end
