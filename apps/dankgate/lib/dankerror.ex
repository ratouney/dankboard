defmodule Dankgate.Error do

  # Since ecto has a really weird error output, here is a EctoError -> String func

  def ectoerrs_to_string(error) do
    [{key, val}] = error
    # Since we have a format like this : 
    # [errorkey: {"errmsg", [errmsg_arg]}]
    #
    # We convert the first error key (if one doesn't work, the others wont either)
    # from an atom to a Capitalized string

    param = 
      key
      |> to_string
      |> String.capitalize
    param <> " " <> put_values(val)
  end


  # Great and simple way to format ecto errors 
  # http://www.thisisnotajoke.com/blog/2015/09/serializing-ecto-changeset-errors-to-jsonapi-in-elixir.html
  
  def put_values({message, values}) do
    # first take the whole message as accumulator and the values as modifiers
    Enum.reduce(values, message, 
      fn {key, val}, acc ->
        # If a key in the values is found in the string, replace it with its value
        String.replace(acc, "%{#{key}}", to_string(val))
      end
    )
  end

  def put_values(_) do
    "fucked up"
  end
end