# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :zashi_hr,
  ecto_repos: [ZashiHR.Repo]

# Configures the endpoint
config :zashi_hr, ZashiHRWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sJ6pkl1uOtzBHJuijh4FDuu2YpbqM+zMHkWeDKTrtGihwV47cvcHeYws05hKOZID",
  render_errors: [view: ZashiHRWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ZashiHR.PubSub,
  live_view: [signing_salt: "F1Q0J8xI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Guardian config details
config :zashi_hr, ZashiHR.Middlewares.Guardian,
  issuer: "zashi_hr",
  secret_key: System.get_env("JWT_SECRET", "")

config :zashi_hr, ZashiHR.Mailer,
  adapter: Bamboo.SendgridAdapter,
  api_key: System.get_env("SENDGRID_API", "")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
