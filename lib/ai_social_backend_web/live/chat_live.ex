defmodule AiSocialBackendWeb.ChatLive do
  use AiSocialBackendWeb, :live_view

  # aim is to create a chat where i can be able to login

  def mount(_params, _args, socket) do
    prompt = [{"", ""}]

    {:ok, assign(socket, prompt: prompt, response: prompt)}
  end

  def handle_event("validate", %{"prompt" => prompt}, socket) do
    prompt
    |> IO.inspect(label: "this is the input in the form")

    {:noreply, socket}
  end

  def handle_event("submit", %{"prompt" => prompt}, socket) do
    responses = AiSocialBackend.AiSocial.AiConnector.connect_to_gemini(prompt)

    send(self(), {:ai_response, {"chat", responses}})

    socket.assigns
    |> IO.inspect(label: "this is you prompt")

    prompts = socket.assigns.prompt
    # i should put the prompt of my nini then send to ai

    my_prompt = {"user", prompt}

    [_ | tail] = prompts ++ my_prompt

    [_ | re_tail] = socket.assigns.response ++ {"chat", responses}

    socket.assigns.prompt
    |> IO.inspect(label: "thi sis ---")

    {:noreply, assign(socket, prompt: [tail], response: [re_tail])}
  end

  def handle_info({:ai_response, message}, socket) do
    message
    |> IO.inspect(label: "this is the respons from ai")

    {:noreply, assign(socket, response: [message])}
  end
end
