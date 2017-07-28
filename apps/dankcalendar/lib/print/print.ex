defmodule DankCalendar.Print do
  @moduledoc """
    Ding
  """

  def date(%{day: day, month: month, year: year}) do
    to_string(day) <> "." <> to_string(month) <> "." <> to_string(year)
  end
end