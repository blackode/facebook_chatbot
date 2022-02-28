defmodule DigiCoin.Clients.CoinGecko do
  use Tesla, only: [:post, :get], docs: false

  @moduledoc """
  Interface to communicate with Slack through a webhook

  Ideally the client_config will return api keys or anything else to custommize the request.
  """
  require Logger

  @client_config Application.compile_env!(:digi_coin, :coin_gecko)

  plug(Tesla.Middleware.BaseUrl, @client_config.base_url)
  plug(Tesla.Middleware.JSON, engine: Jason)

  def search(query) do
    request_path = "search?query=#{query}"

    case get(request_path) do
      {:ok, response} ->
        response.body

      {:error, error} ->
        error
    end
  end

  def coin_market_chart(id) do
    request_path = "coins/#{id}/market_chart"
    query_params = %{
      "vs_currency" => "usd",
      "interval" => "daily",
      "days" => 14
    }

    case get(request_path, query: query_params) do
      {:ok, response} ->
        response.body

      {:error, error} ->
        error
    end
  end
end
