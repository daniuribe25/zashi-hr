defmodule ZashiHRWeb.Graphql.Resolvers.AppSettings do
  alias ZashiHR.Services.AppSettings, as: AppSettingsServices
  alias ZashiHR.Models.Settings.AppSettings

  def list(_parent, args, _info) do
    filter = if Map.has_key?(args, :filter), do: args.filter, else: %{}
    {:ok, AppSettingsServices.list_by_filter(filter)}
  end

  def update(%{app_settings: app_settings}, _) do
    resp = AppSettingsServices.get(app_settings.id)
        |> AppSettingsServices.update(Map.delete(app_settings, :id))

    case resp do
      {:ok, %AppSettings{} = settings} -> {:ok, settings}
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
       _ -> {:error, "Unknown"}
    end
  end
end
