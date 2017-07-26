defmodule DankUserService.User.Fetcher do
  @moduledoc """
    This module is responsible for fetching data from the database, which will be later processed and sent back to the client.

    All of these functions are being called by the `DankUserService.Server` handlers, but can be used in an IEx console.
  """
  alias DankUserService.Repo
  alias DankUserService.Models.User

  @doc """
    This function searches for a specific value of a key given by a map

    To search the user with the username "ratouney", you'd go for :
    ```elixir
    iex(1)> DankUserService.User.Fetcher.get(%{username: "ratouney"})
    {:status, _data}
    ```

    If a match is found, you would recieve :
        {:ok, %DankUserService.Models.User{}}

    If not, you would get :
        {:error, err_msg}
  """
  def get(%{id: id} = map) do
    case Repo.get_by(User, id: id) do
      nil ->
        {:error, "User <#{id}> not found"}
      found ->
        {:ok, found}
    end
  end

  def get(%{email: email}) do
    case Repo.get_by(User, email: email) do
      nil ->
        {:error, "Email <#{email}> not found"}
      found ->
        {:ok, found}
    end
  end

  def get(%{username: username}) do
    case Repo.get_by(User, username: username) do
      nil ->
        {:error, "Username <#{username}> not found"}
      found ->
        {:ok, found}
    end
  end

  def get(_), do: {:error, "No valid key given in the request"}

  @doc """
    This function searches for a value from a map.

    You give in a certain map and a key, and it will search for that key's value in the database.

    For example, this would be the same request as the example in `DankUserService.User.Fetcher.get/1` :
    ```elixir
    iex(1)> user = %{username: "ratouney", email: "dingdong@google.com", password: "notpassword"}
    %{username: "ratouney", email: "dingdong@google.com", password: "notpassword"}
    iex(2)> DankUserService.User.Fetcher.find(user, :username)
    ```

    If a match is found, you would recieve :
        {:ok, %DankUserService.Models.User{}}

    If not, you would get :
        {:error, err_msg}
  """
  def find(%{id: id}, :id) do
    case Repo.get_by(User, id: id) do
      nil ->
        {:error, "User <#{id}> not found"}
      found ->
        {:ok, found}
    end
  end

  def find(%{email: email}, :email) do
    case Repo.get_by(User, email: email) do
      nil ->
        {:error, "User <#{email}> not found"}
      found ->
        {:ok, found}
    end
  end

  def find(%{username: username}, :username) do
    case Repo.get_by(User, username: username) do
      nil ->
        {:error, "User <#{username}> not found"}
      found ->
        {:ok, found}
    end
  end

  def find(_, _), do: {:error, "No valid key given in the request"}
end
