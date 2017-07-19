defmodule Dankgate.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :password_hash, :string
      add :github_key, :string

      timestamps()
    end

  end
end
