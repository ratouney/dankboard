defmodule DankUserService.User do
    use Ecto.Schema
    import Ecto.Changeset

    schema "users" do
        field :username, :string, null: false
        field :email, :string, null: false
        field :github_key, :string
        field :password, :string, virtual: true
        field :password_hash, :string

        timestamps()
    end

    @required_fields ~w{username email password}
    @optional_fields ~w{github_key}

    def changeset(struct, params \\ :empty) do
        struct
        |> cast(params, @required_fields, @optional_fields)
        |> validate_length(:password, min: 6, max: 32)
        |> unique_constraint(:username)
        |> unique_constraint(:email)
        |> hash_password()
    end

    defp hash_password(changeset) do
        case changeset do
            %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
                put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
            _ ->
                changeset
        end
    end
end