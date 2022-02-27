defmodule DigiCoin.Router do
  @moduledoc """
  Main router of the application to handle incoming requests
  """

  use Plug.Router

  require Logger

  @facebook_chat_bot Application.get_env(:digi_coin, :facebook_chat_bot)
  @webhook_verify_token @facebook_chat_bot.webhook_verify_token
  alias DigiCoin.Clients.Bot
  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)
  plug(:dispatch)

  post "/digi_coin/webhook" do
    IO.inspect(:hello,
      label: "<---------- [:hello] ---------->",
      limit: :infinity,
      printable_limit: :infinity
    )

    body_params = conn.body_params
    Bot.webhook_post(body_params)

    conn
    |> put_resp_content_type("application/json")
    |> resp(200, Jason.encode!(%{status: "ok"}))
    |> send_resp()
  end

  get "/digi_coin/webhook" do
    query_params = conn.query_params

    if valid_webhook_token?(query_params) do
      conn
      |> put_resp_content_type("application/json")
      |> resp(200, query_params["hub.challenge"])
      |> send_resp()
    else
      conn
      |> put_resp_content_type("application/json")
      |> resp(403, Jason.encode!(%{status: "error", message: "unauthorized"}))
    end
  end

  match _ do
    conn
    |> put_resp_content_type("application/json")
    |> resp(404, Jason.encode!(%{error: "not found"}))
    |> send_resp()
  end

  defp valid_webhook_token?(query_params) do
    mode = query_params["hub.mode"]
    token = query_params["hub.verify_token"]

    mode == "subscribe" && token == @webhook_verify_token
  end
end
