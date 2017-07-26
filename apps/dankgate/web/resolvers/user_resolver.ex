defmodule Dankgate.UserResolver do
  @moduledoc """
    This module handles the resolvers for the Absinthe/GraphQL queries

    Depending on the query, it calls the appropriate function in the `DankUserService.Client`
  """
  @server_name DankUserService.Server

  @doc """
    This function returns all Users in the database.

    It should never fail since it's a direct call to the database witohut restrictions thus the return format of : 
    ```elixir
    {:ok, users}
    ```

    If there is an error, it would be only if the Database is offline or unreachable, returning : 
    ```elixir
    {:ok, {:error, err_info}}
    ```
  """
  def all(_args, _info) do
    {:ok, DankUserService.Client.Get.all(@server_name)}
  end

  @doc """
    This function finds a certain value for a given key in the database

    It takes as argument a map which contains the key and the value you are looking for.

    ```elixir
    iex(1)> Dankgate.UserResolver.find(%{id: 42}, info)
    ```

    This has no sense since this functions is not called by a user, but is used by GraphQL to built it's response.
  """
  def find(%{id: id}, _info) do
    DankUserService.Client.Get.id(@server_name, id)
  end

  def find(%{username: username}, _info) do
    DankUserService.Client.Get.username(@server_name, username)
  end

  def find(%{email: email}, _info) do
    DankUserService.Client.Get.id(@server_name, email)
  end

  @doc """
    This function is made to transfer the GraphQL creation mutation to the database.

    This function is called by GraphQL to build it's query and is pointless to call as a user.
  """
  def create(args, _info) do
    @server_name
    |> DankUserService.Client.create(args)
    |> handle_answer()
  end

  @doc """
    This function is made to transfer the GraphQL update mutation to the database.

    This function is called by GraphQL to build it's query and is pointless to call as a user.
  """
  def update(%{id: id, user: params}, _info) do
    @server_name
    |> DankUserService.Client.update(id, params)
    |> handle_answer()
  end

  @doc """
    This function is made to transfer the GraphQL deletion mutation to the database.

    This function is called by GraphQL to build it's query and is pointless to call as a user.
  """
  def delete(%{id: id}, _info) do
    case DankUserService.Client.delete(@server_name, id) do
      {:ok, user} ->
        user
      {:error, msg} ->
        {:error, msg}
    end
  end

  @doc """
   This function treats the answers from various `DankUserService.Client` functions

   It just sends back the answer if it's valid but incase of error, it extracts the Changeset errors and converts them into a readable message, sending it back as :

   ```elixir
   {:error, err_msg}
   ```
  """
  defp handle_answer(answer) do
    case answer do
      {:error, %{valid?: false, errors: err}} ->
        {:error, Dankgate.Error.ectoerrs_to_string(err)}
      valid_resp ->
        valid_resp
    end
  end
end