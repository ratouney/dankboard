defmodule Dankboard.User do
  use Dankboard.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :telnum, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :telnum])
    |> validate_required([:name, :email])
  end

end
