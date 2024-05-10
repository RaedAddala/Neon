defmodule AuthService.KeyRotatorWorker do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    # Schedule work to be performed at some point
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    # Do the work you desire here
    {private_key, public_key} = generate_rsa_key_pair()

    priv_path = :code.priv_dir(:auth_service)

    priv_path
    |> Path.join("keys/secret_key.pem")
    |> File.write!(private_key)

    priv_path
    |> Path.join("keys/public_key.pem")
    |> File.write!(public_key)

    # Reschedule once more
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    # In 2 hours
    # TODO: change time to X hours
    Process.send_after(self(), :work, 24 * 60 * 60 * 1000)
  end

  defp generate_rsa_key_pair() do
    {:RSAPrivateKey, _, modulus, publicExponent, _, _, _, _exponent1, _, _, _otherPrimeInfos} =
      rsa_private_key = :public_key.generate_key({:rsa, 2048, 65537})

    rsa_public_key = {:RSAPublicKey, modulus, publicExponent}

    private_key =
      [:public_key.pem_entry_encode(:RSAPrivateKey, rsa_private_key)]
      |> :public_key.pem_encode()

    public_key =
      [:public_key.pem_entry_encode(:RSAPublicKey, rsa_public_key)]
      |> :public_key.pem_encode()

    private_key = String.slice(private_key, 0, String.length(private_key) - 2)
    public_key = String.slice(public_key, 0, String.length(public_key) - 2)
    {private_key, public_key}
  end
end
