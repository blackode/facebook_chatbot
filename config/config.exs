import Config

# Set the `:username` config value here with your Name or Github handler.
config :digi_coin,
  facebook_chat_bot: %{
    base_url: "https://graph.facebook.com/v13.0/me/messages",
    page_access_token: System.get_env("FACEBOOK_PAGE_ACCESS_TOKEN"),
    webhook_verify_token: System.get_env("FACEBOOK_WEBHOOK_VERIFY_TOKEN")
  }

config :tesla, :adapter, Tesla.Adapter.Gun

import_config "#{config_env()}.exs"
