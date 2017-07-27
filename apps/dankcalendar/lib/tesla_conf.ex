defmodule DankCalendar.Tesla.Conf do
  @moduledoc """
   This module handles the setup of Tesla

   It creates the logged in client and handles keeps it as a state in an Agent
  """
  
  @name DankCalendar.Tesla.Conf

  use Tesla

  @doc """
    This function builds the client with the given credentials

    There are specified in the Application Environment in the dev.secret.exs file under the key `{:dankcalendar_service, :username}` and `{:dankcalendar_service, :password}`
  """
  def build(opts \\ %{}) do
    Tesla.build_client [
      {Tesla.Middleware.BasicAuth, Map.merge(%{username: Application.get_env(:dankcalendar_service, :username), 
                                               password: Application.get_env(:dankcalendar_service, :password)}, opts)}
    ]
  end

  @doc """
   This function starts the Agent and initialized it with the given user
  """
  def run() do
    Agent.start_link(fn -> Map.put(%{}, :client, DankCalendar.Tesla.Conf.build()) end, name: @name)
  end

  @doc """
   This function returns the current client

   The client is a function that is given as first argument for the Tesla request
  """
  def get_client(pid \\ @name) do
    Agent.get(pid, &Map.get(&1, :client))
  end

  @doc """
    This function updates the current user with the provided one
  """
  def update_client(pid \\ @name, new_client) do
    Agent.update(pid, &Map.put(&1, :client, new_client))
  end 
end