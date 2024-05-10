defmodule AuthService.SecretFetcher do
  def fetch_signing_secret(_module, _opts) do
    secret =
      "keys/secret_key.pem"
      |> fetch()

    {:ok, secret}
  end

  def fetch_verifying_secret(_module, _headers, _opts) do
    secret =
      "keys/public_key.pem"
      |> fetch()

    {:ok, secret}
  end

  defp fetch(relative_path) do
    :code.priv_dir(:auth_service)
    |> Path.join(relative_path)
    |> JOSE.JWK.from_pem_file()
  end
end
