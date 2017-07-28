defmodule DankCalendar.Abscence do
  @moduledoc """
    Yolo
  """

  def all(action \\ :none) do
    data = 
      DankCalendar.Calendar.data(:get)
      |> Enum.filter(fn %{summary: x} ->
          String.ends_with?(x, " (absent)")
        end)
      case action do
        :show ->
          data |> print()
        _other ->
          data
      end
  end

  def user(username) do
    data = 
      DankCalendar.Calendar.data(:get)
      |> Enum.filter(fn %{summary: x} ->
          String.ends_with?(x, "#{username} (absent)")
        end)
  end

  def print(data) do
    Enum.each(data, fn %{summary: reason, start: start_date, end: end_date} ->
      duration = Timex.Date.diff(start_date, end_date, :days) + 1
      IO.puts reason <> " for " <> to_string(duration) <> " day(s)"
      IO.puts "=> From " <> DankCalendar.Print.date(start_date) <> " to " <> DankCalendar.Print.date(end_date) <> "\n"
      end)
  end
end