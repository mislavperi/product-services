defmodule MainWeb.Router do
  use MainWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :authorization do
    plug(Main.Auth.Authorize)
  end

  scope "/api", MainWeb do
    pipe_through(:api)

    scope "/v1" do
      resources("/products", ProductController, except: [:edit])

      scope "/orders" do
        pipe_through(:authorization)
        post("/", OrderController, :send_order)
      end

      get("/highlight", ProductController, :highlight)
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through([:fetch_session, :protect_from_forgery])

      live_dashboard("/dashboard", metrics: MainWeb.Telemetry)
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through([:fetch_session, :protect_from_forgery])

      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
