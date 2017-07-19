use Mix.Config

import_config "dev.secret.exs"

config :extwitter, :oauth, [
  consumer_key:        Application.get_env(:twitter_service, :consumer_key),
  consumer_secret:     Application.get_env(:twitter_service, :consumer_secret),
  access_token:        Application.get_env(:twitter_service, :access_token),
  access_token_secret: Application.get_env(:twitter_service, :access_token_secret)
]
