defmodule DankUserService.User.Fetcher do
  alias DankUserService.Repo
  alias DankUserService.User
  import Ecto.Query

  def get(%{id: id}) do
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
end
