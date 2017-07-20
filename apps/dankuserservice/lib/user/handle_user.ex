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
    
    def get(_), do: {:error, "Invalid request"}

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
     def find(_, _), do: {:error, "No valid tag given"}

     def create(params \\ %{}) do
        changeset = User.changeset(%User{}, params)
        case Repo.insert(changeset) do
            {:ok, user_created} ->
                user_created
            {:error, %{errors: msg}} ->
                msg
        end
     end

     def delete(params \  %{}) do
         case find(params, :id) do
             {:error, msg} ->
                 IO.puts msg
             {:ok, found} ->
                 Repo.delete(found)
         end
     end

     def update(params \\ %{}, id) do
         # Check if the user exists in the database
         case Repo.get(User, id) do
             nil ->
                 {:error, "User <#{id}> not found"}
             found ->
                # If the given user ID is found, run it
                # Through the Changetset to see if it's valid
                found = User.changeset(found, params)
                # Depending on the update status, either return the errors
                # or the updated user structure
                case Repo.update(found) do
                    {:ok, updated_user} ->
                        updated_user
                    {:error, %{errors: msg}} ->
                        msg
                end
         end
     end
 end