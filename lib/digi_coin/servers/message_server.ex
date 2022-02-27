defmodule DigiCoin.Servers.MessageServer do
  use GenServer

  alias __MODULE__

  # Client API
  def handle_message(message) do
    GenServer.call(MessageServer, {:handle_message, message})
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  # Server API
  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:handle_message, message}, _from, state) do
    IO.inspect(message,
      label: "<---------- [message] ---------->",
      limit: :infinity,
      printable_limit: :infinity
    )

    {:reply, {:ok}, state}
  end
end
