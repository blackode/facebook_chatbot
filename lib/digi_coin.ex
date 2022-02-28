defmodule DigiCoin do
  @moduledoc """
   Main Entry for Events where redirect based on the event category
  """
  alias DigiCoin.Message

  def handle_event(event) do
    case Message.get_messaging(event) do
      %{"message" => message} -> 
        Message.handle_message(message, event)

      %{"postback" => postback} -> 
        Message.handle_postback(postback, event)
        
      _ ->
        error_template = DigiCoin.Template.text(event, "Something went wrong. Our Engineers are working on it.")
        DigiCoin.Clients.Bot.webhook_post(error_template)
    end
  end
end
