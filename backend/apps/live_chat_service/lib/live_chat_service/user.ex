defmodule LiveChatService.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive Jason.Encoder
  embedded_schema do
    field(:username, :string)
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:id, :username])
  end
end
