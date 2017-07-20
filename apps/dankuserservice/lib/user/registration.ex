defmodule DankUserService.User.Registration do
  alias DankUserService.Models.User
  alias DankUserService.Repo

  def create(params \\ :empty) do
    changeset = User.changeset(%User{}, params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        user
      {:error, errlog} ->
        errlog
    end
  end

  def delete(%{id: _id} = params) do
    case DankUserService.User.Fetcher.get(params) do
      {:ok, found} ->
        Repo.delete(found)
      {:error, msg} ->
        raise msg
    end
  end

  def update(params \\ :empty, id) do
    changeset =
      User
      |> Repo.get!(id)
      |> User.changeset(params)

    case Repo.update(changeset) do
      {:ok, user} ->
        user
      {:error, %{errors: msg}} ->
        msg
    end
  end
end
