defmodule Dankuserservice.Repo.Migrations.AddUsername do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :github_key, :string

      timestamps()
    end
  end
end
