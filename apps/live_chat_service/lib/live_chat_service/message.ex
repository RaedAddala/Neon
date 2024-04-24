defmodule LiveChatService.Message do
  alias LiveChatService.User
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:message, :string)

    embeds_one(:user, User)

    field(:date, :string)
  end

  def changeset(message, params \\ %{}) do
    message
    |> cast(params, [:id, :message])
    |> cast_embed(:user)
    |> validate_required([:message])
    |> put_change(:date, DateTime.utc_now())
  end
end
