defmodule LiveChatService.Tokens do
  alias LiveChatService.User
  use Guardian, otp_app: :live_chat_service

  def get_user_data(token) do
    case decode_and_verify(token, %{"typ" => "access"}) do
      {:ok, claims} -> resource_from_claims(claims)
      error -> error
    end
  end

  def subject_for_token(%{id: id}, _claims), do: {:ok, to_string(id)}

  def resource_from_claims(%{"sub" => id} = claims) do
    claims_with_id = Map.put(claims, "id", id)

    user =
      %User{}
      |> User.changeset(claims_with_id)
      |> Ecto.Changeset.apply_changes()
      |> Map.from_struct()

    {:ok, user}
  end

  def fetch_signing_secret(_module, _opts), do: {:error, %{message: "No signing key present."}}
  def fetch_verifying_secret(_module, _headers, _opts), do: {:ok, get_public_key()}

  defp get_public_key do
    public_key_path()
    |> JOSE.JWK.from_pem_file()
  end

  def public_key_path do
    :code.priv_dir(:live_chat_service)
    |> Path.join("keys/public.pem")
  end
end
