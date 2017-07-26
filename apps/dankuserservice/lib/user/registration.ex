defmodule DankUserService.User.Registration do
  alias DankUserService.Models.User
  alias DankUserService.Repo

  def create(params \\ :empty) do
    changeset = User.changeset(%User{}, params)

    Repo.insert(changeset)
  end

  def delete(%{id: _id} = params) do
    case DankUserService.User.Fetcher.get(params) do
      {:ok, found} ->
        Repo.delete(found)
      {:error, msg} ->
        {:error, msg}
    end
  end

  def update(params \\ :empty, id) do
    User
    |> Repo.get!(id)
    |> User.update_changeset(params)
    |> Repo.update()
  end
end
