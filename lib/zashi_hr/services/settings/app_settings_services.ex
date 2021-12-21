defmodule ZashiHR.Services.AppSettings do
  @moduledoc """
  The AppSettings context.
  """

  import Ecto.Query, warn: false
  alias ZashiHR.Repo

  alias ZashiHR.Models.Settings.AppSettings, as: AppSettingsModel
  alias ZashiHR.Services.Helpers.Queries

  def list do
    Repo.all(User)
  end

  def list_by_filter(filter) do
    query = from ua in AppSettingsModel, as: :app_settings, where: ua.active == true
    query = Queries.filter_search(:app_settings, filter, query, [], [], :and)
    Repo.all(query)
  end

  def get(id), do: Repo.get(AppSettingsModel, id)

  def create(attrs \\ %{}) do
    %AppSettingsModel{}
    |> Ecto.Changeset.change(attrs)
    |> AppSettingsModel.changeset(attrs)
    |> Repo.insert()
  end

  def update(%AppSettingsModel{} = app_settings, attrs) do
    app_settings
    |> Ecto.Changeset.change(attrs)
    |> Repo.update()
  end

  def delete(%AppSettingsModel{} = app_settings) do
    Repo.delete(app_settings)
  end

  def change(%AppSettingsModel{} = app_settings, attrs \\ %{}) do
    AppSettingsModel.changeset(app_settings, attrs)
  end
end
