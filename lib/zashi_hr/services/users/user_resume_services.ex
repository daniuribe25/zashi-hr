defmodule ZashiHR.Services.UserResumes do
  @moduledoc """
  The UserResumes context.
  """
  import Ecto.Query, warn: false
  alias ZashiHR.Repo
  alias ZashiHR.Models.Users.UserResume
  alias ZashiHR.Services.Helpers.{Queries, OrderBy, Pagination}

  def list do
    Repo.all(User)
  end

  def list_by_filter(filter, order_by, pagination) do
    query = from ur in UserResume, as: :resumes, where: ur.active == true
    integer_date_list = [:desired_salary, :inserted_at]
    array_list = [:category, :job_type]
    query = Queries.filter_search(:resumes, filter, query, integer_date_list, array_list, :and)
    query = OrderBy.sort(order_by, query)
    query = Pagination.paginate(pagination, query)
    Repo.all(query)
  end

  def get(id), do: Repo.get(UserResume, id)

  def create(attrs \\ %{}) do
    %UserResume{}
    |> Ecto.Changeset.change(attrs)
    |> UserResume.changeset(attrs)
    |> Repo.insert()
  end

  def update(%UserResume{} = user_resume, attrs) do
    user_resume
    |> Ecto.Changeset.change(attrs)
    |> Repo.update()
  end

  def delete(%UserResume{} = user_resume) do
    Repo.delete(user_resume)
  end

  def change(%UserResume{} = user_resume, attrs \\ %{}) do
    UserResume.changeset(user_resume, attrs)
  end
end
