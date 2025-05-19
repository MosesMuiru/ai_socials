defmodule AiSocialBackend.AiSocial.Worker do
  use GenServer

  @spec start_link(Integer) :: pid()
  def start_link(id) do
    GenServer.start_link(__MODULE__, id)
  end

  def init(id) do
    {:ok, id}
  end

  # the broadcaster
  def handle_cast({:broadcast, message, from}, id) do
    IO.inspect("nime pokea")
    Process.send_after(from, {:received, id, message}, 100)
    {:noreply, id}
  end
end
