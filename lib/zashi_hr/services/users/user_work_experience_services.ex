defmodule ZashiHR.Services.UserWorkExperiences do
  @moduledoc """
  The UserWorkExperiences context.
  """

  import Ecto.Query, warn: false
  alias ZashiHR.Repo
  alias ZashiHR.Models.Users.UserWorkExperience
  alias ZashiHR.Services.Helpers.{Queries, OrderBy, Pagination}

  def list do
    Repo.all(UserWorkExperience)
  end

  def list_by_filter(filter, order_by, pagination) do
    query = from uwx in UserWorkExperience, as: :user_experiences, where: uwx.active == true
    date_list = [:from, :to]
    query = Queries.filter_search(:user_experiences, filter, query, date_list, [], :and)
    query = OrderBy.sort(order_by, query)
    query = Pagination.paginate(pagination, query)
    Repo.all(query)
  end

  def get(id), do: Repo.get(UserWorkExperience, id)

  def create(attrs \\ %{}) do
    %UserWorkExperience{}
    |> Ecto.Changeset.change(attrs)
    |> UserWorkExperience.changeset(attrs)
    |> Repo.insert()
  end

  def update(%UserWorkExperience{} = user_work_experience, attrs) do
    user_work_experience
    |> Ecto.Changeset.change(attrs)
    |> Repo.update()
  end

  def delete(%UserWorkExperience{} = user_work_experience) do
    Repo.delete(user_work_experience)
  end

  def change(%UserWorkExperience{} = user_work_experience, attrs \\ %{}) do
    UserWorkExperience.changeset(user_work_experience, attrs)
  end
end
