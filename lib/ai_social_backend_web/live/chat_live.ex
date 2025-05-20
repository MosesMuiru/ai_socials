defmodule AiSocialBackendWeb.ChatLive do
  use AiSocialBackendWeb, :live_view

  # aim is to create a chat where i can be able to login

  def mount(_params, _args, socket) do
    tiles = "user chat"

    assigns = [
      tile = tiles
    ]

    {:ok, assign(socket, assigns)}
  end

  def handle_event("validate", %{"prompt" => prompt}, socket) do
    prompt
    |> IO.inspect(label: "this is the input in the form")

    {:noreply, socket}
  end

  def handle_event("submit", %{"prompt" => prompt}, socket) do
    prompt
    |> IO.inspect(label: "this is you prompt")

    {:noreply, socket}
  end
end
