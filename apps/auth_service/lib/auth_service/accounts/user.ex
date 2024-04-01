defmodule AuthService.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key{:id, Ecto.UUID, autogenerate: true }
  schema "users" do
    field :username, :string
    field :password, :string
    field :email, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/)
    |> validate_format(:password, ~r/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$/)
    |> put_password_hash()
  end

  defp put_password_hash(
    %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
  ) do
    change(changeset, password: Argon2.hash_pwd_salt(password))
    end

  defp put_password_hash(changeset), do: changeset
end
