defmodule ZashiHRWeb.Graphql.Resolvers.Posts do
  alias ZashiHR.Services.Posts, as: PostServices
  alias ZashiHR.Services.Companies, as: CompanyServices

  def list(_parent, args, _info) do
    filter = if Map.has_key?(args, :filter), do: args.filter, else: %{}
    order_by = if Map.has_key?(args, :order_by), do: args.order_by, else: %{}
    paginate = if Map.has_key?(args, :pagination), do: args.pagination, else: %{ size: 0, page: 0 }
    {:ok, PostServices.list_by_filter(filter, order_by, paginate)}
  end

  def by_id(%{id: id}, _info) do
    {:ok, PostServices.get(id)}
  end

  def create(%{post: attrs}, %{context: context}) do
    with true <- context.current_user.post_credits > 0, # has credits
        new_attr <- Map.put(attrs, :company_id, context.current_user.id), # assign company id
        {:ok, post} <- PostServices.create(new_attr), # create post
        {:ok, _} <- decrease_post_credits(context.current_user) do # substract credits
          {:ok, post}
    else
      false -> {:error, "not enough credits to create a post, please buy a posts package"} # 0 credits
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
      _ -> {:error, "Unknown"}
    end
  end

  defp decrease_post_credits(company) do
    com = CompanyServices.get(company.id)
    com
      |> CompanyServices.update(%{ post_credits: company.post_credits - 1 })
  end
end
