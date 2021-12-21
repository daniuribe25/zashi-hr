defmodule ZashiHR.Services.Sessions do
  @moduledoc """
  The Users context.
  """
  import Ecto.Query, warn: false
  alias ZashiHR.Repo

  alias ZashiHR.Models.Users.{User, AdminUser}

  def authenticate(credentials, type) do
    entity = if type === :admin, do: AdminUser, else: User
    with user <- Repo.get_by(entity, email: credentials.email),
        {:ok, _} <- checkpw(user, credentials.password),
        {:ok, jwt_token, _} <- generate_token(user, type) do
      {:ok, %{token: jwt_token, user: user}}
    else
      _ -> {:error}
    end
  end

  defp checkpw(user, password), do: Bcrypt.check_pass(user, password)

  defp generate_token(user, type),
    do: ZashiHR.Middlewares.Guardian.encode_and_sign(user, %{ type: type })

  def generate_invitation_token(user, type),
    do: ZashiHR.Middlewares.Guardian.encode_and_sign(user, %{ type: type })
end
