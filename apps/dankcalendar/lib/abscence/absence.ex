defmodule DankCalendar.Abscence do
  @moduledoc """
    This module handles the abscences.

    It parses the Event list that is created by the `DankCalendar.Calendar` module
  """

  @utc %Timex.TimezoneInfo{abbreviation: "UTC", from: :min, full_name: "UTC", offset_std: 0, offset_utc: 0, until: :max}

  @doc """
    This function shows all abscences.

    If no argument is given, it returns the Event list of all abscenes.
    Else, you can pass the `:show` argument and it will print the abscences as shown :
    (note : if you print it, the values will not be returned, the returned value would be return of the last priting command)

    ```elixir
    iex(2) DankCalendar.Abscence.all(:print)
    John Doe (absent) for 42 days
    => From 18.11.1998 to 31.07.2017
    ```
  """
  def all(action \\ :none) do 
    DankCalendar.Calendar.data(:get)
    |> Enum.filter(fn %{summary: x} ->
          String.ends_with?(x, " (absent)")
       end)
    |> print_or_not(action)
  end

  @doc """
    This function works exactly like `DankCalendar.Abscence.all`

    The only difference is that the first argument is the name you want to search for :
    (the second argument being the optionnal printing)

    ```elixir
    iex(1)> DankCalendar.Abscence.user("John Doe", :print)
    John Doe (absent) for 42 days
    => From 18.11.1998 to 31.07.2017
    ```
  """
  def user(username, action \\ :none) do
    data = 
      DankCalendar.Calendar.data(:get)
      |> Enum.filter(fn %{summary: x} ->
          String.ends_with?(x, "#{username} (absent)")
         end)
    data |> print_or_not(action)
  end

  @doc """
    This function restricts to events in a certain timeframe

    To be valid, an event has to have his start AND end date between the given dates.
    The arguments are the actual Event list, followed by the timeframes given as `Timex.DateTime` structs.
    If those are unclear, use `DankCalendar.Abscence.to_datetime` to make it easier.

    You can also specify the `:show` tag to display the results in text form, this will as usual return the last `IO.puts` call and not the data itself.
  """
  def period(data, from, to, action \\ :none) do 
    Enum.filter(data, fn %{start: start_date, end: end_date} ->
        Timex.Date.compare(start_date, from) == 1 && Timex.Date.compare(end_date, to) == -1
    end)
    |> print_or_not(action)
  end

  @doc """
    Convert a simple 3 field tuple into a Timex.DateTime struct.

    This is a QOL function.
  """
  def to_datetime({day, month, year}, tz \\ @utc) do
    %Timex.DateTime{day: day, month: month, year: year, timezone: tz}
  end

  defp print_or_not(data, action) do
    case action do
      :show ->
        data |> DankCalendar.Print.entry()
      _other ->
        data
      end
  end
end