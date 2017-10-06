module Websocket
  ENV_KEY = "WEBSOCKET_CLIENTS".freeze

  class Middleware # :nodoc:
    Faye::WebSocket.load_adapter("thin")
    KEEPALIVE_TIME = 10

    def initialize(app)
      @app = app
      @clients = Websocket::Clients.new
    end

    def websocket_request
      ws = Faye::WebSocket.new(env, nil, ping: KEEPALIVE_TIME)

      ws.on(:open) do |_event|
        p [:open, ws.object_id]
        @clients.add(ws)
      end

      ws.on(:close) do |event|
        p [:close, ws.object_id, event.code, event.reason]
        @clients.remove(ws)
      end

      ws.rack_response
    end

    def call(env)
      if Faye::WebSocket.websocket?(env)
        websocket_request
      else
        env[ENV_KEY] = @clients
        @app.call(env)
      end
    end
  end
end
