# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :offers_consumer,
  ecto_repos: [OffersConsumer.Repo]

# Configures the endpoint
config :offers_consumer, OffersConsumerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UR9C9EfQ+0wT2xvWbdgmJImDv0AHG0yio96IkpAjjTYDjpr04onr5O2npgc+rnfc",
  render_errors: [view: OffersConsumerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: OffersConsumer.PubSub,
  live_view: [signing_salt: "z+V9HkrC"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
