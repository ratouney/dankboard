defmodule DankCalendar.Calendar do
  @moduledoc """
    This module gets and stores the calendar from the given url
  """

  @name DankCalendar.Calendar
  @calendar_url "https://vacations.fancyerp.com/admin/vacations/calendar.ical"

  use Tesla

  def run do
    Agent.start_link(fn -> 
      %{ 
        client: nil, 
        data: nil
       }
    end, name: @name)
    DankCalendar.Calendar.client(:build)
  end
  
  def client(:get), do: Agent.get(@name, &Map.get(&1, :client))
  def client(:build), do: build_client() |> client(:update)
  def client(_), do: {"Invalid tag", [:get, :build, {"new_client" , :update}]}
  def client(new_client, :update), do: Agent.update(@name, &Map.put(&1, :client, new_client))
  def client(_, _), do: {"Invalid tag", [:get, :build, {"new_client" , :update}]}

  def data(:fetch), do: update_calendar()
  def data(:get), do: Agent.get(@name, &Map.get(&1, :data))
  def data(_), do: {"Invalid tag", [:get, :fetch, {"new_data", :update}]}
  def data(new_data, :update), do: Agent.update(@name, &Map.put(&1, :data, new_data))
  def data(_, _), do: {"Invalid tag", [:get, :fetch, {"new_data", :update}]}

  defp build_client() do
    Tesla.build_client [
      {Tesla.Middleware.BasicAuth, Map.merge(%{username: Application.get_env(:dankcalendar_service, :username), 
                                               password: Application.get_env(:dankcalendar_service, :password)}, %{})}
    ]
  end

  defp update_calendar() do
    case client(:get) do
      nil ->
        {:error, "No client build"}
      client ->
        client
        |> Tesla.get(@calendar_url)
        |> extract_body()
        |> ExIcal.parse
        |> data(:update)
    end
  end

  defp extract_body(%{body: body}), do: body
end