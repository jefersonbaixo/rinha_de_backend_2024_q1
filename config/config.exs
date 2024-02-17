# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :rinha_de_backend_2024_q1,
  ecto_repos: [RinhaDeBackend2024Q1.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :rinha_de_backend_2024_q1, RinhaDeBackend2024Q1Web.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: RinhaDeBackend2024Q1Web.ErrorJSON],
    layout: false
  ],
  pubsub_server: RinhaDeBackend2024Q1.PubSub,
  live_view: [signing_salt: "vqMSD4oL"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
