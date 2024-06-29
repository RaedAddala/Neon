defmodule AuthService.Repo.Migrations.AddFollowers do
  use Ecto.Migration

  def change do
    create table(:follows) do
      add :follower_id, references(:users, type: :uuid)
      add :following_id, references(:users, type: :uuid)
      timestamps()
    end

    create index(:follows, [:follower_id])
    create index(:follows, [:following_id])

    create unique_index(
             :follows,
             [:follower_id, :following_id]
           )
  end
end
