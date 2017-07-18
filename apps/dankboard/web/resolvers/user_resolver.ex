defmodule Dankboard.UserResolver do
    alias Dankboard.Repo
    alias Dankboard.User

    defp errmsg(:id, id), do: "User #{id} not found"
    defp errmsg(:email, mail, id), do: "Email #{mail} already used by user #{id}"

    def all(_args, _info) do
        {:ok, Repo.all(User)}
    end

    def find(%{id: id}, _info) do
        # If the user doesn't exist, return a message
        case Repo.get(User, id) do
            nil ->
                {:error, errmsg(:id, id)}
            user ->
                {:ok, user}
        end
    end

    def create(args, _info) do
        new = 
        %User{}
        |> User.changeset(args)

        %{email: lfmail} = args
        # If the email address is already in use, return an error
        case Repo.get_by(User, email: lfmail) do
            nil -> 
                Repo.insert(new)
            # Probably unsafe for an API but usefull in debug
            %{id: using} ->
                {:error, errmsg(:email, lfmail, using)}
        end
    end

    def update(%{id: id, user: user_params}, _info) do
        %{email: lfmail} = user_params
        # Check if the given user exists
        case Repo.get(User, id) do
            nil ->
                {:error, errmsg(:id, id)}
            toupdate ->
                # If the user is found, 
                # check if the given email address is not already used
                case Repo.get_by(User, email: lfmail) do
                    nil ->
                        toupdate
                        |> User.changeset(user_params)
                        |> Repo.update
                    # Probably unsafe for an API but usefull in debug
                    %{id: using} ->
                        {:error, errmsg(:email, lfmail, using)}
                end
        end
    end
end