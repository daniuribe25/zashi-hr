defmodule ZashiHR.Services.UserAddresses do
  @moduledoc """
  The UserAddresses context.
  """

  import Ecto.Query, warn: false
  alias ZashiHR.Repo
  alias ZashiHR.Models.Users.UserAddress
  alias ZashiHR.Services.Helpers.{Queries, OrderBy, Pagination}

  @spec data :: Dataloader.Ecto.t()
  def data(), do: Dataloader.Ecto.new(ZashiHR.Repo, query: &query/2)
  def query(queryable, _params), do: queryable

  def list_by_filter(filter, order_by, pagination) do
    query = from ued in UserAddress, as: :user_address
    date_list = [:from, :to]
    query = Queries.filter_search(:user_address, filter, query, date_list, [], :and)
    query = OrderBy.sort(order_by, query)
    query = Pagination.paginate(pagination, query)
    Repo.all(query)
  end

  def list do
    Repo.all(UserAddress)
  end

  def get(id), do: Repo.get(UserAddress, id)

  def get_by_user_id(user_id), do: Repo.get_by(UserAddress, user_id: user_id)

  def create(attrs \\ %{}) do
    %UserAddress{}
    |> Ecto.Changeset.change(attrs)
    |> UserAddress.changeset(attrs)
    |> Repo.insert()
  end

  def update(%UserAddress{} = user_address, attrs) do
    user_address
    |> Ecto.Changeset.change(attrs)
    |> Repo.update()
  end

  def delete(%UserAddress{} = user_address) do
    Repo.delete(user_address)
  end

  def change(%UserAddress{} = user_address, attrs \\ %{}) do
    UserAddress.changeset(user_address, attrs)
  end
end
