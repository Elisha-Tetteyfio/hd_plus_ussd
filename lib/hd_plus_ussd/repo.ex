defmodule HdPlusUssd.Repo do
  use Ecto.Repo,
    otp_app: :hd_plus_ussd,
    adapter: Ecto.Adapters.Postgres
end
