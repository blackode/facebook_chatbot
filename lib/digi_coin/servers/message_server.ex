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
    reply = 
      with {:ok, profile} <- Bot.get_profile(event),
           {:ok, first_name} <- Map.fetch(profile, "first_name") do
        welcome_message = Message.welcome_message(first_name)
        Message.get_text_payload(event, welcome_message)
      else
        {:enoprofile, _error} ->
          {:error, "ERROR: No profile found!"}
        :error ->
          {:error, "ERROR: Fetching first_name"}
        _ ->
          {:error, "Something went wrong :). Fixing under process :)"}
      end
    {:reply, reply, state}
  end
end
