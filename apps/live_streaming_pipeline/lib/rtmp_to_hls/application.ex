defmodule LiveStreamingPipeline.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias Membrane.RTMP.Source.TcpServer

  @port 9006
  @local_ip {127, 0, 0, 1}

  @impl true
  def start(_type, _args) do
    File.mkdir_p("output")

    tcp_server_options = %TcpServer{
      port: @port,
      listen_options: [
        :binary,
        packet: :raw,
        active: false,
        ip: @local_ip
      ],
      socket_handler: fn socket ->
        {:ok, _sup, pid} =
          Membrane.Pipeline.start_link(Membrane.Demo.LiveStreamingPipeline, socket: socket)

        {:ok, pid}
      end
    }

    children = [
      # Start the Tcp Server
      # Membrane.Demo.LiveStreamingPipeline,
      %{
        id: TcpServer,
        start: {TcpServer, :start_link, [tcp_server_options]}
      },
      # Start the Telemetry supervisor
      LiveStreamingPipelineWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveStreamingPipeline.PubSub},
      # Start the Endpoint (http/https)
      LiveStreamingPipelineWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveStreamingPipeline.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveStreamingPipelineWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
