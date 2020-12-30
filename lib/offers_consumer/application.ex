defmodule OffersConsumer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      OffersConsumer.Repo,
      # Start the Telemetry supervisor
      OffersConsumerWeb.Telemetry,
      {OfferBroadway, []},

      # Start the PubSub system
      {Phoenix.PubSub, name: OffersConsumer.PubSub},
      # Start the Endpoint (http/https)
      OffersConsumerWeb.Endpoint
      # Start a worker by calling: OffersConsumer.Worker.start_link(arg)
      # {OffersConsumer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OffersConsumer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    OffersConsumerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
