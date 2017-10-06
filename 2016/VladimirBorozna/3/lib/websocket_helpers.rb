module WebsocketHelpers #:nodoc:
  def websocket_clients
    env[Websocket::ENV_KEY]
  end
end
