defmodule ZashiHR.Services.UserEducations do
  @moduledoc """
  The UserEducations context.
  """

  import Ecto.Query, warn: false
  alias ZashiHR.Repo
  alias ZashiHR.Models.Users.UserEducation
  alias ZashiHR.Services.Helpers.{Queries, OrderBy, Pagination}

  @spec data :: Dataloader.Ecto.t()
  def data(), do: Dataloader.Ecto.new(ZashiHR.Repo, query: &query/2)
  def query(queryable, _params), do: queryable

  def list_by_filter(filter, order_by, pagination) do
    query = from ued in UserEducation, as: :user_education
    date_list = [:from, :to]
    query = Queries.filter_search(:user_education, filter, query, date_list, [], :and)
    query = OrderBy.sort(order_by, query)
    query = Pagination.paginate(pagination, query)
    Repo.all(query)
  end

  def list do
    Repo.all(UserEducation)
  end

  def get(id), do: Repo.get(UserEducation, id)

  def create(attrs \\ %{}) do
    %UserEducation{}
    |> Ecto.Changeset.change(attrs)
    |> UserEducation.changeset(attrs)
    |> Repo.insert()
  end

  def update(%UserEducation{} = user_education, attrs) do
    user_education
    |> Ecto.Changeset.change(attrs)
    |> Repo.update()
  end

  def delete(%UserEducation{} = user_education) do
    Repo.delete(user_education)
  end

  def change(%UserEducation{} = user_education, attrs \\ %{}) do
    UserEducation.changeset(user_education, attrs)
  end
end
