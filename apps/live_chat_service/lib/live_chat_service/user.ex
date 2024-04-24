defmodule LiveChatService.User do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:username, :string)
    field(:profile_picture, :string)
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:username])
  end
end
