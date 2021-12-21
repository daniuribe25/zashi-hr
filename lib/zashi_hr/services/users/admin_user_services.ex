defmodule ZashiHR.Services.AdminUsers do
  @moduledoc """
  The AdminUsers context.
  """

  import Ecto.Query, warn: false
  alias ZashiHR.Repo

  alias ZashiHR.Models.Users.AdminUser
  alias ZashiHR.Services.Helpers.{Queries, OrderBy, Pagination}

  @spec data :: Dataloader.Ecto.t()
  def data(), do: Dataloader.Ecto.new(ZashiHR.Repo, query: &query/2)

  def query(queryable, _params), do: queryable

  def list do
    Repo.all(AdminUser)
  end

  def list_by_filter(filter, order_by, pagination) do
    query = from p in AdminUser, as: :admin_users, where: p.active == true
    query = Queries.filter_search(:admin_users, filter, query, [], [], :and)
    query = OrderBy.sort(order_by, query)
    query = Pagination.paginate(pagination, query)
    Repo.all(query)
  end

  def get(id), do: Repo.get(AdminUser, id)

  def get_by_email(email), do: Repo.get_by(AdminUser, email: email)

  def create(attrs \\ %{}) do
    %AdminUser{}
    |> Ecto.Changeset.change(attrs)
    |> AdminUser.changeset(attrs)
    |> Repo.insert()
  end

  def update(%AdminUser{} = admin_user, attrs) do
    admin_user
    |> AdminUser.changeset(attrs)
    |> Repo.update()
  end

  def delete(%AdminUser{} = admin_user) do
    Repo.delete(admin_user)
  end

  def change(%AdminUser{} = admin_user, attrs \\ %{}) do
    AdminUser.changeset(admin_user, attrs)
  end
end
