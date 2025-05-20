defmodule AiSocialBackend.AiSocial.AiConnector do
  # first create a contest

  def connect_to_gemini(text) do
    headers = [
      {"Content-Type", "application/json"}
    ]

    body =
      %{
        system_instruction: %{
          parts: [
            %{
              text: "Lets argue about the politics in kenya"
            }
          ]
        },
        contents: [
          %{
            role: "user",
            parts: [
              %{
                text: text
              }
            ]
          }
        ]
      }
      |> Jason.encode!()

    Finch.build(
      :post,
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=",
      headers,
      body
    )
    |> Finch.request(AiSocialBackend.Finch)
    |> case do
      {:ok, response} ->
        response.status

        response.body
        |> Jason.decode()
        |> IO.inspect(label: "this is the response from the model")
        |> case do
          {:ok, details} ->
            details
            |> response_formatter()
        end
    end
  end

  @spec response_formatter(any()) :: any()
  def response_formatter(response) do
    parts =
      response["candidates"]
      |> List.first()
      |> IO.inspect(label: "this is the details of the parts")

    response =
      parts["content"]["parts"]
      |> List.first()
      |> IO.inspect(label: "this --->")

    response["text"]
    |> IO.inspect(label: "this the last response")
  end
end
