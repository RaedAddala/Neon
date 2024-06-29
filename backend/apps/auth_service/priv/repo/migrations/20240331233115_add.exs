defmodule AuthService.Repo.Migrations.Add do
  use Ecto.Migration

  def change do
    create table("users", primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :email,    :string
      add :username, :string
      add :password, :string

      timestamps()
    end
    create index(:users, [:id])
    create unique_index(:users, [:email])

  end
end
