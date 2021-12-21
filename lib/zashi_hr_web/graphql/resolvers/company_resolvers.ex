defmodule ZashiHRWeb.Graphql.Resolvers.Companies do
  alias ZashiHR.Services.Companies, as: CompanyServices

  def list(_parent, args, _info) do
    filter = if Map.has_key?(args, :filter), do: args.filter, else: %{}
    order_by = if Map.has_key?(args, :order_by), do: args.order_by, else: %{}
    paginate = if Map.has_key?(args, :pagination), do: args.pagination, else: %{ size: 0, page: 0 }
    {:ok, CompanyServices.list_by_filter(filter, order_by, paginate)}
  end

  def by_id(%{id: id}, _info), do: {:ok, CompanyServices.get(id)}

  def create(%{company: attrs}, _info) do
    case CompanyServices.create(attrs) do
      {:ok, company} -> {:ok, company}
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
      _ -> {:error, "Unknown"}
    end
  end

  def add_post_credits(%{credits: credits}, %{ context: context }) do
    with true <- Map.has_key?(context, :current_user), # verify token logged
      company <- CompanyServices.get(context.current_user.id), # get company
      {:ok, updatedCompany} <- CompanyServices.update(company, %{ post_credits: company.post_credits + credits }) do # update credits
        {:ok, updatedCompany}
    else
      false -> {:error, "Unauthorized"}
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
      _ -> {:error, "Unknown"}
    end
  end

end
