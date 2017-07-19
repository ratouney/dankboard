defmodule Dankuserservice.User do
    use Ecto.Schema
    import Ecto.Changeset

    schema "users" do
        field :username, :string, null: false
        field :email, :string, null: false
        field :github_key, :string

        timestamps()
    end

    @required_fields ~w{username email}
    @optional_fields ~w{github_key}

    def changeset(struct, params \\ :empty) do
        struct
        |> cast(params, @required_fields, @optional_fields)
    end
end