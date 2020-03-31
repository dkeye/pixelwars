# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :pixelwars, PixelwarsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "E8BQPH5le1V29XN6GALXoxxzPGufM9VVX53H4A2c8M9F3zJm0pnlGjXb1Wp6mds7",
  render_errors: [view: PixelwarsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Pixelwars.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
