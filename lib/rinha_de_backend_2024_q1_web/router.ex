defmodule RinhaDeBackend2024Q1Web.Router do
  use RinhaDeBackend2024Q1Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RinhaDeBackend2024Q1Web do
    pipe_through :api

    post "/clientes/:id/transacoes", TransactionsController, :create
    get "/clientes/:id/extrato", CustomersController, :show
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:rinha_de_backend_2024_q1, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: RinhaDeBackend2024Q1Web.Telemetry
    end
  end
end
