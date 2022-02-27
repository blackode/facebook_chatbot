defmodule DigiCoin.Servers.MessageServer do
  use GenServer

  alias __MODULE__
  alias DigiCoin.Clients.Bot
  alias DigiCoin.Message

  # Client API
  def handle_message(message, event) do
    GenServer.call(MessageServer, {:handle_message, message, event})
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
  def handle_call({:handle_message, _message, event}, _from, state) do
    with {:ok, profile} <- Bot.get_profile(event),
         first_name <- Map.get(profile, "first_name") do
      welcome_message = Message.welcome_message(first_name)
      reply = Message.get_text_payload(event, welcome_message)
      {:reply, reply, state}
    else
      _ ->
        {:reply, {:error, "something went wrong :) We are fixing."}, state}
    end
  end
end
