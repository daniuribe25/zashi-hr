defmodule ZashiHRWeb.Graphql.Resolvers.Users do
  alias ZashiHR.Services.Users, as: UsersServices
  alias ZashiHR.Services.AppSettings, as: AppSettingsServices
  alias ZashiHR.Models.Users.User
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
    {:ok, token, _} <- ZashiHR.Services.Sessions.generate_invitation_token(user, :common) do
        ZashiHR.MailClient.send_invitation_link("dani.uribe25@gmail.com", token)
        it_email = System.get_env("IT_FRONT_EMAIL", "")
        if it_email != "", do: ZashiHR.MailClient.send_invitation_link(it_email, token)
        {:ok, user}
    else
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
      _ -> {:error, "Unknown"}
    end
  end

  def send_user_invitation(%{email: email}, _info) do
    with %User{} = user <- UsersServices.get_by_email(email),
        {:ok, %User{} = updated_user} <- UsersServices.update(user, %{ last_invitation_at: NaiveDateTime.local_now() }),
        {:ok, token, _} <- ZashiHR.Services.Sessions.generate_invitation_token(updated_user, :common),
        %Bamboo.Email{} = _ = ZashiHR.MailClient.send_invitation_link("dani.uribe25@gmail.com", token) do
        it_email = System.get_env("IT_FRONT_EMAIL", "")
        if it_email != "", do: ZashiHR.MailClient.send_invitation_link(it_email, token)
        {:ok, updated_user}
      else
        {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
        nil -> {:error, "No registered email"}
        _ -> {:error, "Unknown"}
      end
  end

  def is_user_invitation_valid(%{token: token}, _info) do
    with {:ok, claims} <- Guardian.decode_and_verify(token),
      {:ok, user} <- Guardian.resource_from_claims(claims),
        %{ value: value } <- AppSettingsServices.get_by_name("user_invitation_expires_after") do
        seconds = String.to_integer(value) * 60
        {
          :ok,
          NaiveDateTime.compare(NaiveDateTime.add(user.last_invitation_at, seconds), NaiveDateTime.local_now()) == :gt
        }
      else
        {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
        {:error, %CaseClauseError{term: {:error, {:case_clause, "p"}}}} -> {:error, "Unauthorized"}
        _ -> {:error, "Unknown"}
      end
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

  def update(%{user: user}, %{ context: context }) do
    %{ id: id, role: role } = context.current_user
    with true <- Map.has_key?(context, :current_user),
        true <- (role == "common" && Integer.to_string(id) == user.id) || Enum.member?(["admin", "super_admin"], role),
        {:ok, %User{} = updated_user} <- UsersServices.get(user.id) |> UsersServices.update(Map.delete(user, :id)) do
      {:ok, updated_user}
    else
      {:error, %Ecto.Changeset{} = changeset} -> {:error, changeset}
      false -> {:error, "Unauthorized"}
       _ -> {:error, "Unknown"}
    end
  end
end
