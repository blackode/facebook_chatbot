defmodule DigiCoin.Message do
  @moduledoc """
  Message oriented functions like set
  """
  @type message() :: %{
          mid: String.t(),
          text: String.t()
        }

  @type recipient() :: %{
          id: String.t()
        }

  @type sender() :: %{
          id: String.t()
        }

  @type event() :: map()

  alias DigiCoin.Servers.MessageServer
  alias DigiCoin.Template
  alias DigiCoin.Clients.Bot

  @spec get_message(event) :: message()
  def get_message(event) do
    messaging = get_messaging(event)
    messaging["message"]
  end

  @spec get_recipient(event) :: recipient()
  def get_recipient(event) do
    messaging = get_messaging(event)
    messaging["recipient"]
  end

  @spec get_sender(event) :: sender()
  def get_sender(event) do
    messaging = get_messaging(event)
    messaging["sender"]
  end

  def get_messaging(event) do
    [entry | _any] = event["entry"]
    [messaging | _any] = entry["messaging"]
    messaging
  end

  def get_text_payload(event, text) do
    %{
      "recipient" => %{
        "id" => get_sender(event)["id"]
      },
      "message" => %{
        "text" => text
      }
    }
  end

  def welcome_message(first_name \\ "")

  def welcome_message(first_name) when is_binary(first_name) do
    "Welcome to DigiCoin #{first_name} :)"
  end

  def welcome_message(%{"first_name" => first_name}) do
    welcome_message(first_name)
  end

  def handle_message(message, event) do
    {:ok, body} = MessageServer.handle_message(message, event)
    Bot.webhook_post(body)

    buttons = [
      {:postback, "Coin Id", "coin_search_by_id"},
      {:postback, "Coin Name", "coin_search_by_name"}
    ]
    template_title = "How do you want search coins?"
    select_coin_search_template = Template.buttons(event, template_title, buttons)

    Bot.webhook_post(select_coin_search_template)
  end

  def handle_postback(postback, event) do
    {:ok, body} = MessageServer.handle_postback(postback, event)
    Bot.webhook_post(body)
  end
end
