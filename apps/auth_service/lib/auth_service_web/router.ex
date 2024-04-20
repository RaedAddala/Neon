defmodule AuthServiceWeb.Router do
  alias AuthServiceWeb.UserController
  use AuthServiceWeb, :router

  pipeline :static do
    plug Plug.Static,
      at: "/uploads",
      from: {:auth_service, "priv/static/uploads/profile_pictures"}
  end

  scope "/", AuthServiceWeb do
    scope "/uploads" do
      pipe_through :static
      get "/*path", ErrorController, :notfound
    end
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    scope "/users" do
      resources "/users", UserController
      post "/login", UserController, :login
      post "/logout", UserController, :logout
      post "/register", UserController, :register
    end
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:auth_service, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: AuthServiceWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
