defmodule LiveStreamingPipelineWeb.Router do
  use LiveStreamingPipelineWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {LiveStreamingPipelineWeb.LayoutView, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(LiveStreamingPipelineWeb.AllowIframe)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", LiveStreamingPipelineWeb do
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/video/:filename", HlsController, :index)
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveStreamingPipelineWeb do
  #   pipe_through :api
  # end
end
