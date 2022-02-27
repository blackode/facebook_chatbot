{application,digi_coin,
    [{compile_env,
         [{digi_coin,
              [facebook_chat_bot],
              {ok,#{base_url =>
                        <<"https://graph.facebook.com/v13.0/me/messages">>,
                    page_access_token =>
                        <<"EAAG4CvRuia8BAIvBYlZAhZCBX7yW2obJedarZBqeBDTC0EUEftRQjoHColtq2AAqALBh7ZA73RnPLHJl0Wa9JySr3zXSueRA5qZBOF5DYhxNlhIiGxZCavuBtllz2wXnPw0sZAsxDRj5WmbgVoMpbjd5VfWZAltw0zbPysx1ujgeE8j7TCoauay0NIvGiHlZAwNIZD">>,
                    webhook_verify_token =>
                        <<"8079b281-7b4f-43a9-8d56-4e2a67ec5f44">>}}}]},
     {applications,
         [kernel,stdlib,elixir,logger,idna,tesla,gun,jason,plug_cowboy]},
     {description,"digi_coin"},
     {modules,
         ['Elixir.DigiCoin','Elixir.DigiCoin.Application',
          'Elixir.DigiCoin.Behaviors.ChatBot','Elixir.DigiCoin.Clients.Bot',
          'Elixir.DigiCoin.HTTP','Elixir.DigiCoin.Router',
          'Elixir.DigiCoin.Servers.MessageServer']},
     {registered,[]},
     {vsn,"0.1.0"},
     {mod,{'Elixir.DigiCoin.Application',[]}}]}.
