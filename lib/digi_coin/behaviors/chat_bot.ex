defmodule DigiCoin.Behaviors.ChatBot do
  @moduledoc """
  Bot behavior.
  """

  @type request_response :: {:ok, response :: Tesla.Env.t()} | {:error, response :: any()}

  @callback webhook_post(chain_response :: map()) :: request_response()
end
