defmodule TwitterService.Auth do
  @doc """
  This function is used to authenticate the application

  At the moment, it is an HotFix, since it appears it is not working by default from the current config/dev.exs
  TODO: fix the config behavior
  """
  def auth_me do
    ExTwitter.configure(
      consumer_key:        Application.get_env(:twitter_service, :consumer_key),
      consumer_secret:     Application.get_env(:twitter_service, :consumer_secret),
      access_token:        Application.get_env(:twitter_service, :access_token),
      access_token_secret: Application.get_env(:twitter_service, :access_token_secret)
    )
  end
end
