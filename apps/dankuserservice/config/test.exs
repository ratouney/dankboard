use Mix.Config

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :dankuserservice, DankUserService.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "dankuser_dev",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox