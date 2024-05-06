defmodule AuthService.SecretFetcher do
  def fetch_signing_secret(_module, _opts) do
    secret =
      "./priv/keys/secret_key.pem"
      |> fetch()

    {:ok, secret}
  end

  @spec fetch_verifying_secret(any(), any(), any()) :: {:ok, list() | JOSE.JWK.t()}
  def fetch_verifying_secret(_module, _headers, _opts) do
    secret =
      "./priv/keys/public_key.pem"
      |> fetch()

    {:ok, secret}
  end

  defp fetch(relative_path) do
    # :code.priv_dir(:debug_guardian)
    # |> Path.join(relative_path)
    relative_path
    |> JOSE.JWK.from_pem_file()
  end
end
