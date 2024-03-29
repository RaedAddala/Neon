defmodule AuthService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AuthServiceWeb.Telemetry,
      AuthService.Repo,
      {DNSCluster, query: Application.get_env(:auth_service, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AuthService.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AuthService.Finch},
      # Start a worker by calling: AuthService.Worker.start_link(arg)
      # {AuthService.Worker, arg},
      # Start to serve requests, typically the last entry
      AuthServiceWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AuthService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AuthServiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
