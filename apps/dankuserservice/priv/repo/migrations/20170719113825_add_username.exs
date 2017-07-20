defmodule DankUserService.Repo.Migrations.AddUsername do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :github_key, :string, null: false, default: ""

      timestamps()
    end

    create unique_index :users, :username
    create unique_index :users, :email
  end
end
