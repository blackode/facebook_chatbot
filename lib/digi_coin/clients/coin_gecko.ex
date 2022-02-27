defmodule DigiCoin.Clients.CoinGecko do
  use Tesla, only: [:post, :get], docs: false

  @moduledoc """
  Interface to communicate with Slack through a webhook

  Ideally the client_config will return api keys or anything else to custommize the request.
  """
  require Logger

  @client_config Application.compile_env!(:digi_coin, :coin_gecko)

  alias DigiCoin.Message

  plug(Tesla.Middleware.BaseUrl, @client_config.base_url)
  plug(Tesla.Middleware.JSON, engine: Jason)

  def search(event) do
    text = Message.get_message(event)["text"]
    request_path = "search?query=#{text}"

    case get(request_path) do
      {:ok, response} ->
        response.body

      {:error, error} ->
        error
    end
  end

  def coin_market_chart(event) do
    id = Message.get_message(event)["text"]
    request_path = "coins/#{id}/market_chart/?vs_currency=usd&days=14&interval=daily"

    case get(request_path) do
      {:ok, response} ->
        response.body

      {:error, error} ->
        error
    end
  end
end
