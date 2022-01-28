defmodule ZashiHRWeb.Graphql.Resolvers.UserAddress do
  alias ZashiHR.Services.UserAddresses, as: UserAddressServices
  alias ZashiHR.Models.Users.UserAddress

  def list(_parent, args, _info) do
    filter = if Map.has_key?(args, :filter), do: args.filter, else: %{}
    order_by = if Map.has_key?(args, :order_by), do: args.order_by, else: %{}
    paginate = if Map.has_key?(args, :pagination), do: args.pagination, else: %{size: 0, page: 0}
    {:ok, UserAddressServices.list_by_filter(filter, order_by, paginate)}
  end

  def get(_parent, _args, %{context: context}) do
    case UserAddressServices.get_by_user_id(context.current_user.id) do
      %UserAddress{} = user_address_found -> {:ok, user_address_found}
      nil -> {:ok, nil}
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
      _ -> {:error, "Unknown"}
    end
  end

  def create(%{user_address: attrs}, %{context: context}) do
    new_attrs = Map.put(attrs, :user_id, context.current_user.id)

    with nil <- UserAddressServices.get_by_user_id(new_attrs.user_id),
         {:ok, user_address} <- UserAddressServices.create(new_attrs) do
      {:ok, user_address}
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, changeset}

      %UserAddress{} = _user_address_found ->
        {:error, "There is an address already registered for this user, try updating it"}

      _ ->
        {:error, "Unknown"}
    end
  end

  def update(%{user_address: user_address}, %{context: context}) do
    with %UserAddress{} = address_to_update <-
           UserAddressServices.get_by_user_id(context.current_user.id),
         {:ok, %UserAddress{} = updated} <-
           UserAddressServices.update(address_to_update, user_address) do
      {:ok, updated}
    else
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
      nil -> {:error, "Not address found to update"}
      _ -> {:error, "Unknown"}
    end
  end
end
