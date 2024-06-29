defmodule LiveChatServiceWeb.ChatChannel do
  alias LiveChatService.Message
  use LiveChatServiceWeb, :channel

  @impl true
  def join("chat:" <> _username, payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (chat:username).
  @impl true
  def handle_in("shout", payload, socket) do
    if current_user = Map.get(socket.assigns, :user) do
      message_data = Map.put(payload, "user", current_user)
      message_changeset = Message.changeset(%Message{}, message_data)

      if(message_changeset.valid?) do
        message = Ecto.Changeset.apply_changes(message_changeset)
        broadcast(socket, "shout", message)
      end
    end

    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
