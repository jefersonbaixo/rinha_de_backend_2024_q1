defmodule RinhaDeBackend2024Q1.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RinhaDeBackend2024Q1Web.Telemetry,
      RinhaDeBackend2024Q1.Repo,
      {DNSCluster, query: Application.get_env(:rinha_de_backend_2024_q1, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: RinhaDeBackend2024Q1.PubSub},
      # Start a worker by calling: RinhaDeBackend2024Q1.Worker.start_link(arg)
      # {RinhaDeBackend2024Q1.Worker, arg},
      # Start to serve requests, typically the last entry
      RinhaDeBackend2024Q1Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RinhaDeBackend2024Q1.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RinhaDeBackend2024Q1Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
