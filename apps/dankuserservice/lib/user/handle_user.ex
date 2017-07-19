defmodule Dankuserservice.HandleUser do
    alias Dankuserservice.Repo
    alias Dankuserservice.User
    import Ecto.Query


    def find(%{id: id}, :id) do
        case Repo.get_by(User, id: id) do
            nil ->
                {:error, "User <#{id}> not found"}
            found ->
                {:ok, found}
        end
    end
    def find(_noid, :id), do: {:error, "Not valid id given"}

    def find(%{email: email}, :email) do
        case Repo.get_by(User, email: email) do
            nil ->
                {:error, "User <#{email}> not found"}
            found ->
                {:ok, found}
        end
    end
    def find(_, :email), do: {:error, "Not valid email given"}

    def find(%{username: username}, :username) do
        case Repo.get_by(User, username: username) do
            nil ->
                {:error, "User <#{username}> not found"}
            found ->
                {:ok, found}
        end
    end
    def find(_, :username), do: {:error, "Not valid username given"}

    def find(_, _), do: {:error, "Not valid tag given"}

    def add(params \\ %{}) do
        %User{}
        |> User.changeset(params)
        |> Repo.insert!
    end

    def delete(params \\ %{}) do
        case find(params, :id) do
            {:error, msg} ->
                IO.puts msg
            {:ok, found} ->
                Repo.delete(found)
        end
    end
end