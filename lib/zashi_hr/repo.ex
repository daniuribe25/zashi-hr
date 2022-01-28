defmodule ZashiHR.Repo do
  use Ecto.Repo,
    otp_app: :zashi_hr,
    adapter: Ecto.Adapters.Postgres
end
