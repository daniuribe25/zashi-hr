defmodule ZashiHR.Services.Companies do
  @moduledoc """
  The Companies context.
  """

  import Ecto.Query, warn: false
  alias ZashiHR.Repo

  alias ZashiHR.Models.Companies.Company
  alias ZashiHR.Services.Helpers.{Queries, OrderBy, Pagination}

  def data(), do: Dataloader.Ecto.new(ZashiHR.Repo, query: &query/2)

  def query(queryable, _params), do: queryable

  def list do
    Repo.all(Company)
  end

  def list_by_filter(filter, order_by, pagination) do
    query = from p in Company, as: :companies, where: p.active == true
    query = Queries.filter_search(:companies, filter, query, [], [], :and)
    query = OrderBy.sort(order_by, query)
    query = Pagination.paginate(pagination, query)
    Repo.all(query)
  end

  def get(id), do: Repo.get(Company, id)

  def get_by_email(email), do: Repo.get_by(Company, email: email)

  def get_by_phone(phone), do: Repo.get_by(Company, phone: phone)

  def create(attrs \\ %{}) do
    %Company{}
    |> Company.changeset(attrs)
    |> Repo.insert()
  end

  def update(%Company{} = company, attrs) do
    company
    |> Ecto.Changeset.change(attrs)
    |> Repo.update()
  end

  def delete(%Company{} = company) do
    Repo.delete(company)
  end

  def change(%Company{} = company, attrs \\ %{}) do
    Company.changeset(company, attrs)
  end

end
