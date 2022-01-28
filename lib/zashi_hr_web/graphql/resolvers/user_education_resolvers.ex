defmodule ZashiHRWeb.Graphql.Resolvers.UserEducation do
  alias ZashiHR.Services.UserEducations, as: UserEducationServices

  def list_own(_parent, args, %{context: context}) do
    filter =
      if Map.has_key?(args, :filter),
        do: Map.put(args.filter, :user_id, %{eq: context.current_user.id}),
        else: %{user_id: %{eq: context.current_user.id}}

    order_by = if Map.has_key?(args, :order_by), do: args.order_by, else: %{}
    paginate = if Map.has_key?(args, :pagination), do: args.pagination, else: %{size: 0, page: 0}
    {:ok, UserEducationServices.list_by_filter(filter, order_by, paginate)}
  end

  def create(%{user_education: attrs}, %{context: context}) do
    new_attrs = Map.put(attrs, :user_id, context.current_user.id)

    case UserEducationServices.create(new_attrs) do
      {:ok, user_education} -> {:ok, user_education}
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
      _ -> {:error, "Unknown"}
    end
  end
end
