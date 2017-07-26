defmodule DankUserService.Server do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

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
