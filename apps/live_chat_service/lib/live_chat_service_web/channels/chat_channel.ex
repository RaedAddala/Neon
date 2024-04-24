defmodule LiveChatServiceWeb.ChatChannel do
  alias Ecto.Changeset
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

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (chat:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    message_changeset = Message.changeset(%Message{}, payload)

    with %Changeset{changes: message, valid?: true} <- message_changeset,
         %{user: user_changeset} <- message,
         %Changeset{changes: user, valid?: true} <- user_changeset do
      message_struct = %{message | user: user}
      broadcast(socket, "shout", message_struct)
    end

    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
