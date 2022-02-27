defmodule DigiCoin.Clients.Bot do
  use Tesla, only: [:post], docs: false

  @moduledoc """
  Interface to communicate with Slack through a webhook

  Ideally the client_config will return api keys or anything else to custommize the request.
  """

  require Logger

  @behaviour DigiCoin.Behaviors.ChatBot

  @client_config Application.compile_env!(:digi_coin, :facebook_chat_bot)

  plug(Tesla.Middleware.BaseUrl, @client_config.base_url)
  plug(Tesla.Middleware.JSON, engine: Jason)

  alias DigiCoin.Servers.MessageServer

  @impl true
  def webhook_post(chain_response) do
    body = chat_message_body(chain_response)
    access_token = @client_config.page_access_token
    request_path = "?access_token=#{access_token}"

    case post(request_path, body) do
      {:ok, response} ->
        {:ok, response}

      {:error, error} ->
        Logger.error("Received error trying to post to Slack with reason #{inspect(error)}")

        {:error, error}
    end
  end

  defp chat_message_body(chain_response) do
    IO.inspect(chain_response,
      label: "<---------- [chain_response] ---------->",
      limit: :infinity,
      printable_limit: :infinity
    )

    MessageServer.handle_message(chain_response)
  end
end
