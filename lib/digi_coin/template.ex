defmodule DigiCoin.Template do
  @moduledoc """
  Facebook Bot UI Templates
  """
  alias DigiCoin.Message

  @doc """
  Prepares the buttons template for the given buttons
  """
  @type message_button_type :: :postback | :url
  @type message_button :: {message_button_type, String.t(), String.t()}
  @type message_buttons :: [message_button]

  @spec buttons(map(), String.t(), message_buttons) :: map()
  def buttons(event, template_title, buttons) do
    buttons = Enum.map(buttons, &prepare_button/1)

    %{
      "recipient" => %{
        "id" => Message.get_sender(event)["id"]
      },
      "message" => %{
        "attachment" => %{
          "type" => "template",
          "payload" => %{
            "template_type" => "button",
            "text" => template_title,
            "buttons" => buttons
          }
        }
      }
    }
  end

  def generic(event, _list_title, elements) do
    %{
  "recipient" => %{
    "id"=> Message.get_sender(event)["id"]
  }, 
  "message" => %{
    "attachment" => %{
      "type"=> "template",
      "payload" => %{
        "template_type"=> "generic",
        "elements"=> elements
      }
    }
  }
}
  end

  def prepare_button({:postback, title, payload}) do
    %{
      "type" => "postback",
      "title" => title,
      "payload" => payload
    }
  end

  def text(event, text) do
    %{
      "recipient" => %{
        "id" => Message.get_sender(event)["id"]
      },
      "message" => %{
        "text" => text
      }
    }
  end
end
