defmodule DigiCoin.MessageTest do
  use ExUnit.Case
  doctest DigiCoin.Message
  alias DigiCoin.Message

  test "get message from entry" do
    event = %{
      "entry" => [
        %{
          "id" => "704406986315551",
          "messaging" => [
            %{
              "message" => %{
                "mid" =>
                  "m_e1yv01fnV1wOjbuAS6tou8WB-NS9iqVS9WivGJx8m5b2ldl1YEtfGjqKy_6C8HiMJMkTVYhYofK1sG741dxEpQ",
                "text" => "hello"
              },
              "recipient" => %{"id" => "704406986315551"},
              "sender" => %{"id" => "5428533393826749"},
              "timestamp" => 1_645_953_390_333
            }
          ],
          "time" => 1_645_953_390_608
        }
      ],
      "object" => "page"
    }

    assert Message.get_message(event) == %{
             "mid" =>
               "m_e1yv01fnV1wOjbuAS6tou8WB-NS9iqVS9WivGJx8m5b2ldl1YEtfGjqKy_6C8HiMJMkTVYhYofK1sG741dxEpQ",
             "text" => "hello"
           }
  end
end
