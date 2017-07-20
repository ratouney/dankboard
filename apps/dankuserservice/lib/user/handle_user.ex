defmodule DankUserService.HandleUser do
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
        
    end

    def find(%{id: id}, :id) do
        case Repo.get_by(User, id: id) do
            nil ->
                {:error, "User <#{id}> not found"}
            found ->
                {:ok, found}
        end
    end
    def find(_no_id, :id), do: {:error, "No valid id given"}

    def find(%{email: email}, :email) do
        case Repo.get_by(User, email: email) do
            nil ->
                {:error, "User <#{email}> not found"}
            found ->
                {:ok, found}
        end
    end
    def find(_no_mail, :email), do: {:error, "No valid email given"}

    def find(%{username: username}, :username) do
        case Repo.get_by(User, username: username) do
            nil ->
                {:error, "User <#{username}> not found"}
            found ->
                {:ok, found}
        end
    end
    def find(_no_user, :username), do: {:error, "No valid username given"}

    def find(_, _), do: {:error, "No valid tag given"}

    def create(params \\ %{}) do
        case find(params, :username) do
            {:error, _} ->
                case find(params, :email) do
                    {:error, _} -> 
                        %User{}
                        |> User.changeset(params)
                        |> Repo.insert!
                    {:ok, _} ->
                        {:error, "Email exists"}
                end
            {:ok, _} ->
                {:error, "Username exists"}
        end
    end

    def delete(params \\ %{}) do
        case find(params, :id) do
            {:error, msg} ->
                IO.puts msg
            {:ok, found} ->
                Repo.delete(found)
        end
    end

    def update(params \\ %{}, id) do
        case Repo.get(User, id) do
            nil ->
                {:error, "User <#{id}> not found"}
            found ->
                found
                |> User.changeset(params)
                |> Repo.update
        end
    end
end