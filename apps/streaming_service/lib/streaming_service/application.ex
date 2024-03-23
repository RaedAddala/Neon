defmodule StreamingService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      StreamingServiceWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:streaming_service, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: StreamingService.PubSub},
      # Start a worker by calling: StreamingService.Worker.start_link(arg)
      # {StreamingService.Worker, arg},
      # Start to serve requests, typically the last entry
      StreamingServiceWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StreamingService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StreamingServiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
