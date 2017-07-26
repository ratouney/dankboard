defmodule DankUserService.Server do
  use GenServer
  @moduledoc """
    This is the Server part of the DankUserService

    Messages coming from the DankUserService.Client are treated by the handlers and converted into the according Database query handlers
  """

  @doc """
    This function starts the Server

    It returns a tuple with the status and it's data, so either :
    ```elixir
    {:ok, <PID:1337>}
    ```
    Or in case of error : 
    ```elixir
    {:error, err_msg}
    ```
  """
  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc """
    This function returns values depending on the according request

    The valid requests are :

    ```{:create, params}``` -> `DankUserService.Client.create/2`

    ```{:update, id, params}``` -> `DankUserService.Client.update/3`

    ```{:get, :all}``` -> `DankUserService.Client.Get.all/1`

    ```{:get, key, val}``` -> `DankUserService.Client.Get`

    ```{:delete, id}``` -> `DankUserService.Client.delete/2`
  """
  def handle_call({:create, params}, _from, userlist) do
    case DankUserService.User.Registration.create(params) do
      {:ok, user} ->
        {:reply, {:ok, user}, [user | userlist]}
      {:error, msg} ->
        {:reply, {:error, msg}, userlist}
      _ ->
        {:reply, {:error, "Invalid_database_syntax"}, userlist}
    end
  end

  def handle_call({:update, id, params}, _from, userlist) do
    case DankUserService.User.Fetcher.get(%{id: id}) do
      {:error, msg} ->
        {:reply, {:error, msg}, userlist}
      {:ok, user} ->
        rt = DankUserService.User.Registration.update(params, user.id)
        {:reply, rt, userlist}
    end
  end

  def handle_call({:get, :all}, _from, _state) do
    users = DankUserService.Repo.all(DankUserService.Models.User)

    {:reply, users, users}
  end
  
  def handle_call({:get, key, val}, _from, userlist) do
    case DankUserService.User.Fetcher.get(Map.put(%{}, key, val)) do
      {:ok, user} ->
        {:reply, {:ok, user}, userlist}
      {:error, msg} ->
        {:reply, {:error, msg}, userlist}
    end
  end

  def handle_call({:delete, id}, _from, userlist) do
    case DankUserService.User.Fetcher.get(%{id: id}) do
      {:ok, user} ->
        rt = DankUserService.User.Registration.delete(user)
        {:reply, rt, userlist}
      {:error, msg} ->
        {:reply, {:error, msg}, userlist}
    end
  end
end
