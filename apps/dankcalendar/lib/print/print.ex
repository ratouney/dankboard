defmodule DankCalendar.Print do
  @moduledoc """
    This module handles printing the results from the `DankCalendar.Abscence` module
  """

  @doc """
    Prints out a date stored as a keyword map as "day.month.year"
  """
  def date(%{day: day, month: month, year: year}) do
    to_string(day) <> "." <> to_string(month) <> "." <> to_string(year)
  end

  @doc """
    This function prints the entry for a given dataset.
    
    Syntax is as follows :
    ```elixir
    $Username (absent) for $days_absent days
    => From $Start_Date to $End_Date
    ```
  """
  def entry(data) do
    Enum.each(data, fn %{summary: reason, start: start_date, end: end_date} ->
      duration = Timex.Date.diff(start_date, end_date, :days) + 1
      IO.puts reason <> " for " <> to_string(duration) <> " day(s)"
      IO.puts "=> From " <> DankCalendar.Print.date(start_date) <> " to " <> DankCalendar.Print.date(end_date)
      end)
  end
end