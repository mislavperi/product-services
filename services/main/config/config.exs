# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :main,
  ecto_repos: [Main.Repo]

# Configures the endpoint
config :main, MainWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: MainWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Main.PubSub,
  live_view: [signing_salt: "rXfgAAAq"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :main, Main.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

config :brod,
  clients: [
    kafka_client: [
      endpoints: [broker: 9092],
      auto_start_producers: true,
      # The following :ssl and :sasl configs are not
      # required when running kafka locally unauthenticated
      # ssl: true,
      # sasl: {
      #   :plain,
      #   System.get_env("KAFKA_CLUSTER_API_KEY"),
      #   System.get_env("KAFKA_CLUSTER_API_SECRET")
      # }
    ]
  ]
