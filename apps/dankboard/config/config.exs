# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :dankboard,
  ecto_repos: [Dankboard.Repo]

# Configures the endpoint
config :dankboard, Dankboard.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "H4rdhY+RCMcPThIgfInsTkNzrcco0TPUtxf/9S7MuuVlID7kXrt+Dl/9Xb/0+qbS",
  render_errors: [view: Dankboard.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Dankboard.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
