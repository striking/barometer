defmodule Barometer.Repo do
  use Ecto.Repo,
    otp_app: :barometer,
    adapter: Ecto.Adapters.Postgres
end
