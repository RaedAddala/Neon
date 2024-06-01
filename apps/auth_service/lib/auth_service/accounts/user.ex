defmodule AuthService.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias AuthService.Accounts.Follow
  alias AuthService.Repo
  alias AuthService.Accounts.User

  @derive {Jason.Encoder, except: [:password, :__meta__]}
  @primary_key {:id, Ecto.UUID, autogenerate: true}
  schema "users" do
    field(:username, :string)
    field(:email, :string)
    field(:password, :string)
    field(:profile_picture, :string)

    many_to_many :followers, User,
      join_through: Follow,
      join_keys: [following_id: :id, follower_id: :id]

    many_to_many :following, User,
      join_through: Follow,
      join_keys: [follower_id: :id, following_id: :id]

    timestamps(type: :utc_datetime)
  end

  @required_fields [:username, :email, :password]
  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> validate_format(:email, ~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/)
    |> validate_format(:password, ~r/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$/)
    |> validate_format(:username, ~r/^(?!.*[^\w-]).{1,39}$/)
    |> put_password_hash()
  end

  def changeset_add_follower(%User{} = user, follower) do
    user
    |> Ecto.Changeset.change()
    |> put_assoc(:followers, [follower | user.followers])
    |> Repo.update!()
  end

  def changeset_remove_follower(%User{} = user, follower) do
    user
    |> Ecto.Changeset.change()
    |> put_assoc(:followers, List.delete(user.followers, follower))
    |> Repo.update!()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password: Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
