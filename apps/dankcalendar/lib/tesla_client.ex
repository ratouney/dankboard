defmodule DankCalendar.Tesla.Client do
  @moduledoc """
   This module handles the usage of Tesla

   It gets the generated client from an Agent and handles the query to get the latest ICS file
  """

  @calendar_url "https://vacations.fancyerp.com/admin/vacations/calendar.ical"

  def get_calendar(part \\ :full) do
    client = 
    case DankCalendar.Tesla.Conf.run() do
      {:ok, pid} ->
        DankCalendar.Tesla.Conf.get_client(pid)
      {:error, {:already_started, pid}} ->
        DankCalendar.Tesla.Conf.get_client(pid)
      _nope ->
        raise "This should not have happened"
    end
    output = Tesla.get(client, @calendar_url)
    case part do
      :full -> 
        output
      :body ->
        %{body: body} = output
        to_string(body)
      _ ->
        :invalid_tag
    end
  end

  def get_only_abscences(icl, user) do
    icl
    |> Enum.filter(fn %{summary: x} ->
      String.ends_with?(x, "#{user} (absent)")
    end)
    |> print_log
  end

  def get_only_abscences(icl) do
    icl
    |> Enum.filter(fn %{summary: x} ->
      String.ends_with?(x, "(absent)")
    end)
    |> print_log
  end

  defp print_log(list) do
    Enum.each(list, fn x -> 
      %{summary: summary, start: erl_start_date, end: erl_end_date} = x
      %{day: start_day, month: start_month, year: start_year} = erl_start_date
      %{day: end_day, month: end_month, year: end_year} = erl_end_date
      start_date = {start_day, start_month, start_year}
      end_date = {end_day, end_month, end_year}
      username = 
        summary
        |> String.replace(" (absent)", "")
      IO.puts username <> " izded from " <> get_date(start_date) <> " to " <> get_date(end_date)
      IO.puts "=> Duration : " <> get_diff(start_date, end_date)
    end)
  end

  defp get_date({day, month, year}) do
    to_string(day) <> "." <> to_string(month) <> "." <> to_string(year)
  end

  defp get_diff({start_day, start_month, start_year}, {end_day, end_month, end_year}) do
    day_diff = end_day - start_day
    month_diff = end_month - start_month
    year_diff = end_year - start_year
    day_count = day_diff + (month_diff * 30) + (year_diff * 365)
    if day_count > 1 do
      to_string(day_count) <> " days"
    else
      "1 day"
    end
  end
end