defmodule ZashiHR.Middlewares.Guardian do
  use Guardian, otp_app: :zashi_hr
  alias ZashiHR.Services.{Users, AdminUsers}
  alias ZashiHR.Models.Users.{User, AdminUser}

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def resource_from_claims(%{"sub" => id, "type" => type}) do
    case type do
      "common" -> get_user(id)
      "admin" -> get_admin_user(id)
    end
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

  defp get_user(id) do
    case Users.get(id) do
      %User{} = user -> {:ok, user}
      _ -> {:error, :resource_not_found}
    end
  end

  defp get_admin_user(id) do
    case AdminUsers.get(id) do
      %AdminUser{} = admin_user -> {:ok, admin_user}
      _ -> {:error, :resource_not_found}
    end
  end
end
