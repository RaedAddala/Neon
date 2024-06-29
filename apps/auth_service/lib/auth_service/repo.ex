defmodule AuthService.Repo do
  use Ecto.Repo,
    otp_app: :auth_service,
    adapter: Ecto.Adapters.Postgres
end
