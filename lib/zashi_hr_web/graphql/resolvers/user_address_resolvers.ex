defmodule ZashiHRWeb.Graphql.Resolvers.UserAddress do
alias ZashiHR.Services.UserAddresss, as: UserAddressServices

  def list(_parent, args, _info) do
    filter = if Map.has_key?(args, :filter), do: args.filter, else: %{}
    order_by = if Map.has_key?(args, :order_by), do: args.order_by, else: %{}
    paginate = if Map.has_key?(args, :pagination), do: args.pagination, else: %{ size: 0, page: 0 }
    {:ok, UserAddressServices.list_by_filter(filter, order_by, paginate)}
  end

  def create(%{user_address: attrs}, %{context: context}) do
    new_attrs = Map.put(attrs, :user_id, context.current_user.id)
    case UserAddressServices.create(new_attrs) do
      {:ok, user_address} -> {:ok, user_address}
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
      _ -> {:error, "Unknown"}
    end
  end
end
