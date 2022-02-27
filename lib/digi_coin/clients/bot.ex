defmodule DigiCoin.Clients.Bot do
  use Tesla, only: [:post, :get], docs: false

  @moduledoc """
  Interface to communicate with FB BOT through a webhook
  """

  require Logger

  @behaviour DigiCoin.Behaviors.ChatBot

  @client_config Application.compile_env!(:digi_coin, :facebook_chat_bot)

  alias DigiCoin.Message

  plug(Tesla.Middleware.BaseUrl, @client_config.base_url)
  plug(Tesla.Middleware.Query, access_token: @client_config.page_access_token)
  plug(Tesla.Middleware.JSON, engine: Jason)

  @impl true
  def webhook_post(event) do
    body = Message.handle_event(event)

    request_path = "v13.0/me/messages"

    case post(request_path, body) do
      {:ok, response} ->
        {:ok, response}

      {:error, error} ->
        error
    end
  end

  def get_profile(event) do
    sender = Message.get_sender(event)

    case get(sender["id"]) do
      {:ok, response} ->
        {:ok, response.body}

      {:error, error} ->
        error
    end
  end
end
