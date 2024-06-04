defmodule LiveStreamingPipelineWeb.AllowIframe do
  @moduledoc """
  Allows affected ressources to be open in iframe.
  """

  alias Plug.Conn

  def init(opts \\ %{}), do: Enum.into(opts, %{})

  def call(conn, _opts) do
    Conn.delete_resp_header(conn, "x-frame-options")
  end
end
