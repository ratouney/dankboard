defmodule DankUserService.Client do
  use GenServer

  def start_server do
    DankUserService.Server.start_link
  end

  def close_server(pid) do
    GenServer.stop(pid)
  end

  def create(pid, params) do
    GenServer.call(pid, {:create, params})
  end

  def update(pid, id, params) do
    GenServer.call(pid, {:update, id, params})
  end

  def delete(pid, id) do
    GenServer.call(pid, {:delete, id})
  end
end

defmodule DankUserService.Client.Get do
  def all(pid) do
    GenServer.call(pid, {:get, :all})
  end

  def id(pid, val) do
    GenServer.call(pid, {:get, :id, val})
  end

  def username(pid, val) do
    GenServer.call(pid, {:get, :username, val})
  end

  def email(pid, val) do
    GenServer.call(pid, {:get, :email, val})
  end
end