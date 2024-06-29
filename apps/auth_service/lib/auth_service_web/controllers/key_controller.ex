defmodule AuthServiceWeb.KeyController do
  use AuthServiceWeb, :controller
  action_fallback(AuthServiceWeb.FallbackController)

  def getKey(conn, _params) do
    priv_path = :code.priv_dir(:auth_service)

    key =
      priv_path
      |> Path.join("keys/public_key.pem")
      |> File.read!()

    IO.inspect(conn)

    conn
    |> put_status(:ok)
    |> json(%{"key" => key})
  end
end
