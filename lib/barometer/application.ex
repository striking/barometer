defmodule Barometer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BarometerWeb.Telemetry,
      # Start the Ecto repository
      Barometer.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Barometer.PubSub},
      # Start Finch
      {Finch, name: Barometer.Finch},
      # Start the Endpoint (http/https)
      BarometerWeb.Endpoint
      # Start a worker by calling: Barometer.Worker.start_link(arg)
      # {Barometer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Barometer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BarometerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
