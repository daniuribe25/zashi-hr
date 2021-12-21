defmodule ZashiHR.Services.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, only: [from: 2], warn: true
  alias ZashiHR.Repo
  alias ZashiHR.Services.Helpers.{Queries, OrderBy, Pagination}
  alias ZashiHR.Models.Companies.Post

  def data(), do: Dataloader.Ecto.new(ZashiHR.Repo, query: &query/2)

  def query(queryable, _params), do: queryable

  def list do
    Repo.all(Post)
  end

  def list_by_filter(filter, order_by, pagination) do
    query = from p in Post, as: :posts, where: p.active == true

    integer_list = [:salary_base, :salary_up_to, :vacants, :inserted_at]
    array_list = [:labels, :job_type]
    query = Queries.filter_search(:posts, filter, query, integer_list, array_list, :and)
    query = OrderBy.sort(order_by, query)
    query = Pagination.paginate(pagination, query)
    Repo.all(query)
  end

  def get(id), do: Repo.get(Post, id)

  def create(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update(%Post{} = post, attrs) do
    post
    |> Ecto.Changeset.change(attrs)
    |> Repo.update()
  end

  def delete(%Post{} = post) do
    Repo.delete(post)
  end

  def change(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end
end
