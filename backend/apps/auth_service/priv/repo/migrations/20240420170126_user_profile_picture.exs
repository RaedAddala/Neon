defmodule AuthService.Repo.Migrations.UserProfilePicture do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :profile_picture, :string
    end
  end
end
