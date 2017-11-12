module Telegram
  module Bot
    # Monkey patching for Webhooks
    class Client
      def listen(response, &block)
        fetch_updates(response, &block)
      end

      def fetch_updates(response)
        response = [JSON.parse(response)]
        response.each do |data|
          update = Types::Update.new(data)
          @offset = update.update_id.next
          yield update
        end
      end
    end
  end
end
