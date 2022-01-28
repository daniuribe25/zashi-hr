defmodule ZashiHRWeb.Graphql.Resolvers.Session do
  alias ZashiHR.Services.Sessions, as: SessionsServices
  alias ZashiHR.Services.Users, as: UsersServices

  def authenticate(%{credentials: credentials}, _info) do
    case SessionsServices.authenticate(credentials, :common) do
      {:ok, user_token} -> {:ok, user_token}
      {:error} -> {:error, "invalid credentials"}
    end
  end

  def authenticate_admin(%{credentials: credentials}, _info) do
    case SessionsServices.authenticate(credentials, :admin) do
      {:ok, user_token} -> {:ok, user_token}
      {:error} -> {:error, "invalid credentials"}
    end
  end

  def get_own(_params, %{context: context}) do
    case Map.has_key?(context, :current_user) do
      true ->
        case context.current_user.role do
          "common" -> {:ok, %{:user => UsersServices.get(context.current_user.id)}}
          _ -> {:error, "Unknown"}
        end

      _ ->
        {:error, "Unknown"}
    end
  end
end
