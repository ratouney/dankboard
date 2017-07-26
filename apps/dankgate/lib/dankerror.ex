defmodule Dankgate.Error do
  @moduledoc """
    This module is made to create readable errors from variable output

    For now it's only handling Ecto.Changeset errors and converting them into a single string
  """

  @doc """
    Converts an ecto changeset errorset to a error message as a string

    First, we separate the main tag from the message part, for example :
        iex(1)> [{key, msg}] = {username: ["has already been taken", {}]}

    The key which is an atom in converted to a string and capitalized.
    The message itself has arguments so it's treatet by the Dankgate.Error.put_values/1 function

    Once this is done, the both parts are fused so the part above would be :
    ```{username: ["has already been taken", {}]}``` -> ```"Username has already been taken"```
    
  """
  def ectoerrs_to_string(error) do
    [{key, val}] = error
    param = 
      key
      |> to_string
      |> String.capitalize
    param <> " " <> put_values(val)
  end

  @doc """
    This function is specificaly made to interpolate the keys from an argument list into a string

    This was applied to Ecto.Changesets here :
    [http://www.thisisnotajoke.com/blog/2015/09/serializing-ecto-changeset-errors-to-jsonapi-in-elixir.html]

    It takes the values from the argument list next ot the string and applies them by replacing the found key by their values.

    As an example, if the given password for a user creation is too short, an errorset like this would be given :

    -> ```{"should be at least %{count} character(s)", [count: 6, validation: :length, min: 6]}```

    which becomes becomes

    -> ```"should be at leat 6 characters(s)"```
  """
  def put_values({message, values}) do
    Enum.reduce(values, message, 
      fn {key, val}, acc ->
        String.replace(acc, "%{#{key}}", to_string(val))
      end
    )
  end

  def put_values(_) do
    "fucked up"
  end
end