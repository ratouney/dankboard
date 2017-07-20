use Mix.Config

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :DankUserService, DankUserService.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "dankusers_dev",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox