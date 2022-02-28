defmodule DigiCoin.Postback do
  
  @moduledoc """
  Postback messages handler when user send reply via buttons
  """
  alias DigiCoin.Clients.CoinGecko
  alias DigiCoin.Template

  def handle_postback(%{"payload" => "coin_search_by_id"}, event) do
    results = CoinGecko.search("bitcoin")
    coins = process_coins(results)
    Template.generic(event, "Slect one to fetch prices for last 14 days", coins)
  end

  def handle_postback(%{"payload" => "coin_search_by_name"}, event) do
    results = CoinGecko.search("btc")
    coins = process_coins(results)
    Template.generic(event, "Slect one to fetch prices for last 14 days", coins)
  end

  def handle_postback(%{"payload" => coin_id, "title" => "GetPrices"}, event) do
    results = CoinGecko.coin_market_chart(coin_id)
    coin_prices_string = process_coin_prices(results)
    Template.text(event, coin_prices_string)
  end

  defp process_coins(%{"coins" => coins}) do
    coins
    |> Enum.take(5)
    |> Enum.map(fn coin -> 
      buttons = 
        [{:postback, "GetPrices", coin["id"]}]
        |> Enum.map(&Template.prepare_button/1)

      %{
        "title" => coin["name"],
        "subtitle" => coin["symbol"],
        "buttons" => buttons
      }
    end)
  end

  defp process_coin_prices(%{"prices" => coin_prices}) do
    coin_prices
    |> Enum.map(fn [unixdatetime, price] -> 
      dt = DateTime.from_unix!(unixdatetime, :millisecond)
      date = "#{dt.year}-#{dt.month}-#{dt.day}"
      price = "USD #{price}"

      "#{date} -> #{price}"
    end)
    |> Enum.join("\n")
  end
end
