defmodule DankUserService.Repo.Migrations.ChangePasswordFieldName do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :password
      add :password_hash, :string
    end
  end
end
