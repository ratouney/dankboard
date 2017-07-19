defmodule Dankuserservice.HandleUser do
    alias Dankuserservice.Repo
    alias Dankuserservice.User
    import Ecto.Query

    def find_mail(%{email: lfmail}) do
        case Repo.get_by(User, email: lfmail) do
            nil ->
                {:error, "Email #{lfmail} not found"}
            found ->
                {:ok, found}    
        end
    end
    def find_mail(_), do: {:error, "No valid email given"}

    def find_user(%{username: lfuser}) do
        case Repo.get_by(User, username: lfuser) do
            nil ->
                {:error, "User #{lfuser} not found"}
            found ->
                {:ok, found}
        end
    end
    def find_user(_), do: {:error, "No valid username given"}

    def find_id(%{id: lfid}) do
        case Repo.get_by(User, id: lfid) do
            nil ->
                {:error, "User #{lfid} not found"}
            found ->
                {:ok, found}
        end
    end
    def find_id(_), do: {:error, "No valid id given"}

    def add(params \\ %{}) do
        %User{}
        |> User.changeset(params)
        |> Repo.insert!
    end
end