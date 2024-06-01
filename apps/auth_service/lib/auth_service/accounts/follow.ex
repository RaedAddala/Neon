defmodule AuthService.Accounts.Follow do
  use Ecto.Schema

  schema "follows" do
    field :following_id, Ecto.UUID
    field :follower_id, Ecto.UUID
    timestamps()
  end

  @attrs [:follower_id, :following_id]

  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, @attrs)
    |> Ecto.Changeset.unique_constraint([:follower_id, :following_id])
  end
end
