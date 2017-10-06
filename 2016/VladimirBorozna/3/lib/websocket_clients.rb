module Websocket
  class Clients #:nodoc:
    def initialize(clients = [])
      @clients = clients
    end

    def add(client)
      @clients << client
    end

    def remove(client)
      @clients.delete(client)
    end

    def broadcast_message(data)
      @clients.each { |client| client.send(data) }
    end
  end
end
