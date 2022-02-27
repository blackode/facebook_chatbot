defmodule DigiCoin.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: DigiCoin.Router, options: [port: 4000]},
      DigiCoin.Servers.MessageServer
    ]

    opts = [strategy: :one_for_one, name: DigiCoin.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
