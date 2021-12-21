defmodule ZashiHRWeb.Graphql.Resolvers.Users do
  alias ZashiHR.Services.Users, as: UsersServices
  alias ZashiHR.Middlewares.Guardian

  def list(_parent, args, _info) do
    filter = if Map.has_key?(args, :filter), do: args.filter, else: %{}
    order_by = if Map.has_key?(args, :order_by), do: args.order_by, else: %{}
    paginate = if Map.has_key?(args, :pagination), do: args.pagination, else: %{ size: 0, page: 0 }
    {:ok, UsersServices.list_by_filter(filter, order_by, paginate)}
  end

  def by_id(%{id: user_id}, _info) do
    {:ok, UsersServices.get(user_id)}
  end

  def create(%{user: attrs}, _info) do
    with {:ok, user} <- UsersServices.create(attrs),
    {:ok, token, _} = ZashiHR.Services.Sessions.generate_invitation_token(user, :common) do
        ZashiHR.MailClient.send_invitation_link("dani.uribe25@gmail.com", token)
        {:ok, user}
    else
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
      _ -> {:error, "Unknown"}
    end
  end

  def is_user_invitation_valid(%{token: token}, _info) do

  end

  def set_user_password(%{user: attrs}, _info) do
    if attrs.password === attrs.confirm_password do
      with {:ok, claims} <- Guardian.decode_and_verify(attrs.token),
          {:ok, user} <- Guardian.resource_from_claims(claims),
          %{password_hash: password_hash} <- Bcrypt.add_hash(attrs.password),
          {:ok, _} <- UsersServices.update(user, %{ password_hash: password_hash }) do
        {:ok, user}
      else
        {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
        _ -> {:error, "invalid operation"}
      end
    else
      {:error, "passwords don't match"}
    end
  end
end
