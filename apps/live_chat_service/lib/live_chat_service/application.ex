defmodule LiveChatService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LiveChatService.FetchPublicKeyWorker,
      LiveChatServiceWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:live_chat_service, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LiveChatService.PubSub},
      # Start a worker by calling: LiveChatService.Worker.start_link(arg)
      # {LiveChatService.Worker, arg},
      # Start to serve requests, typically the last entry
      LiveChatServiceWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveChatService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveChatServiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
