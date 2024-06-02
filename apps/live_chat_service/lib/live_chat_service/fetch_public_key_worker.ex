defmodule LiveChatService.FetchPublicKeyWorker do
  use GenServer

  @public_key_endpoint "http://auth-service:4000/getKey"

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(state) do
    # Schedule work to be performed on start
    make_keys_directory!()
    fetch_public_key!()

    schedule_work()

    {:ok, state}
  end

  @impl true
  def handle_info(:work, state) do
    # Do the desired work here
    fetch_public_key!()

    # Reschedule once more
    schedule_work()

    {:noreply, state}
  end

  defp fetch_public_key! do
    with %{status_code: 200, body: body} <- HTTPoison.get!(@public_key_endpoint),
         %{"key" => key} <- Jason.decode!(body) do
      File.write!(public_key_path(), key)
    end
  end

  defp public_key_path do
    :code.priv_dir(:live_chat_service)
    |> Path.join("keys/public.pem")
  end

  defp make_keys_directory! do
    public_key_path()
    |> Path.dirname()
    |> File.mkdir_p!()
  end

  defp schedule_work do
    # We schedule the work to happen in 2 hours (written in milliseconds).
    # Alternatively, one might write :timer.hours(2)
    Process.send_after(self(), :work, 2 * 60 * 60 * 1000)
  end
end
