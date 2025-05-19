defmodule AiSocialBackend.AiSocial.OpenAi do
  def connect_to_open_ai(text) do
    headers = [
      {"Content-Type", "application/json"},
      {"Authorzation", "Bearer"}
    ]

    body =
      %{
        model: "gpt-t0-mini",
        store: true,
        messages: [
          %{
            role: "user",
            content: text
          }
        ]
      }
      |> Jason.encode!()

    Finch.build(
      :post,
      "https://api.openai.com/v1/chat/completions",
      headers,
      body
    )
  end
end
