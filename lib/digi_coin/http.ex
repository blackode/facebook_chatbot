defmodule DigiCoin.HTTP do
  @moduledoc """
  HTTP client interface
  """

  @spec post(String.t(), map(), map(), Keyword.t()) :: {:ok, Tesla.Env.t()} | {:error, any()}
  def post(path, body, config, opts \\ []) do
    # Usually in `opts` you'll receive the client configuration, which can be ignored or can
    # be used to construct the body of the request, append authorization to headers, etc... but for this it might not be necessary.
    config
    |> client()
    |> Tesla.post(path, body, opts)
  end

  defp client(client_config) do
    middlewares = [
      {Tesla.Middleware.JSON, engine: Jason},
      {Tesla.Middleware.BaseUrl, client_config.base_url}
    ]

    Tesla.client(middlewares, Tesla.Adapter.Gun)
  end
end
