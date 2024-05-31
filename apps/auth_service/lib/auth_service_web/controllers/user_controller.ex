defmodule AuthServiceWeb.UserController do
  use AuthServiceWeb, :controller

  alias AuthService.Accounts
  alias AuthService.Accounts.User
  alias AuthService.Guardian

  action_fallback(AuthServiceWeb.FallbackController)

  # def new(conn, _) do
  #   changeset = Accounts.change_user(%User{})
  #   maybe_user = Guardian.Plug.current_resource(conn)

  #   if maybe_user do
  #     redirect(conn, to: "/protected")
  #   else
  #     render(conn, "new.html", changeset: changeset, action: Routes.session_path(conn, :login))
  #   end
  # end

  def register(conn, user_params) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> auth_reply(user)
    end
  end

  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    Accounts.authenticate_user(email, password)
    |> auth_reply(conn)
  end

  def logout(conn, _) do
    conn
    # This module's full name is Auth.Accounts.Guardian.Plug,
    |> Guardian.Plug.sign_out()
    |> IO.inspect()

    # and the arguments specified in the Guardian.Plug.sign_out()
    |> json(:ok)
  end

  defp auth_reply({:ok, user}, conn) do
    conn
    |> Guardian.Plug.sign_in(user, %{username: user.username})
    |> parse_auth_response()
  end

  defp auth_reply({:error, reason}, conn) do
    conn
    |> put_status(:unauthorized)
    |> json(%{"error" => reason})
  end

  defp auth_reply(conn, user) do
    auth_reply({:ok, user}, conn)
  end

  defp parse_auth_response(conn) do
    json(conn, %{"token" => conn.private.guardian_default_token})
  end

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
