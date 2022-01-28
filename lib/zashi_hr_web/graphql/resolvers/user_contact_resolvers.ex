defmodule ZashiHRWeb.Graphql.Resolvers.UserContact do
  alias ZashiHR.Services.UserContacts, as: UserContactServices
  alias ZashiHR.Models.Users.UserContact

  def get(_parent, _args, %{context: context}) do
    case UserContactServices.get_by_user_id(context.current_user.id) do
      %UserContact{} = user_contact_found -> {:ok, user_contact_found}
      nil -> {:ok, nil}
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
      _ -> {:error, "Unknown"}
    end
  end

  def create_or_update(%{user_contact: attrs}, %{context: context}) do
    new_attrs = Map.put(attrs, :user_id, context.current_user.id)

    case UserContactServices.get_by_user_id(context.current_user.id) do
      %UserContact{} = contact_to_update ->
        {:ok, %UserContact{} = updated} = UserContactServices.update(contact_to_update, attrs)
        {:ok, updated}

      nil ->
        {:ok, user_contact} = UserContactServices.create(new_attrs)
        {:ok, user_contact}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, changeset}

      _ ->
        {:error, "Unknown"}
    end
  end
end
