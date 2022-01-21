defmodule ZashiHRWeb.Graphql.Resolvers.AppSettings do
  alias ZashiHR.Services.AppSettings, as: AppSettingsServices
  alias ZashiHR.Models.Settings.AppSettings

  def list(_parent, args, _info) do
    filter = if Map.has_key?(args, :filter), do: args.filter, else: %{}
    {:ok, AppSettingsServices.list_by_filter(filter)}
  end

  def update(%{app_settings: app_settings}, _) do
    Enum.each(app_settings, fn app_s ->
      AppSettingsServices.get(app_s.id)
      |> AppSettingsServices.update(Map.delete(app_s, :id))
    end)
    {:ok, true}
  end
end
