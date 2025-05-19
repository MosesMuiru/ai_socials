defmodule AiSocialBackend.CreateAi do
  @spec create_ai(integer()) :: boolean()
  def create_ai(number_of_ais) when is_integer(number_of_ais) do
    true

    # Open five process
    process_pids =
      1..number_of_ais
      |> Enum.map(fn processes_id ->
        {:ok, pid} = AiSocialBackend.AiSocial.Worker.start_link(processes_id)

        pid
      end)

    # then the number of those process should communicate

    process_pids
    |> Enum.map(fn pid ->
      pid
      |> GenServer.cast({:broadcast, "Hello from this process", self()})
    end)

    # the pids or the process names of the process should be saved , either in in memoty store or somewhere else

    # collect responses

    receive_responses()
  end

  @spec create_ai(String.t()) :: boolean()
  def create_ai(number_of_ais) when is_binary(number_of_ais) do
    false
  end

  def receive_responses() do
    Process.sleep(2000)

    receive do
      {:received, id, message} ->
        IO.inspect(message, label: "Process #{id} received the message")
        receive_responses()
    end
  end
end
