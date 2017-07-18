defmodule Dankboard.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :telnum, :string

      timestamps()
    end

  end
end
