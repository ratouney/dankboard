defmodule TwitterService.Stream do
  @timeout 1000

  def stream(tracks) when is_list(tracks) do
    tracks = Enum.join(tracks, ", ")
    stream(tracks)
  end

  def stream(tracks) when is_bitstring(tracks) do
    ExTwitter.stream_filter([track: tracks], @timeout)
  end

  def stream(_), do: :error

  def display(stream) do
    stream
    |> Stream.map(fn(x) -> x.text end)
    |> Stream.map(fn(x) -> IO.puts "#{x}\n---------------\n" end)
    |> Enum.to_list
  end
end
