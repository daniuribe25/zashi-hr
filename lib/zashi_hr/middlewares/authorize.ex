defmodule ZashiHR.Middlewares.Authorize do
  @behaviour Absinthe.Middleware

  @impl true
  def call(resolution, allowed_roles) do
    with %{ current_user: current_user } <- resolution.context,
        true <- correct_role?(current_user.role, allowed_roles) do
        resolution
    else
      _ -> resolution |> Absinthe.Resolution.put_result({:error, "unauthorized"})
    end
  end

  defp correct_role?(role, allowed_roles),
    do: String.to_atom(role) in allowed_roles
end
