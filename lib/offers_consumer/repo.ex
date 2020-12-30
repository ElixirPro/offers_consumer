defmodule OffersConsumer.Repo do
  use Ecto.Repo,
    otp_app: :offers_consumer,
    adapter: Ecto.Adapters.Postgres
end
