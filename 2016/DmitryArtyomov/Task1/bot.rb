require 'telegram/bot'
require 'require_all'
require_all 'lib'

# Servlet launched on POST request from Telegram
class Bot < WEBrick::HTTPServlet::AbstractServlet
  def do_POST(request, response)
    run(request.body)
    response.status = 200
    response['Content-Type'] = 'text/plain'
    response.body = 'OK'
  end

  private

  def run(request_body)
    Telegram::Bot::Client.run(Secret::TELEGRAM_TOKEN) do |bot|
      msg_handler = MessageHandler.new(bot)
      cb_handler = CallbackHandler.new(msg_handler)
      bot.listen(request_body) do |data|
        case data
        when Telegram::Bot::Types::CallbackQuery then cb_handler.handle(data)
        when Telegram::Bot::Types::Message then msg_handler.handle(data)
        end
      end
    end
  end
end

module Telegram
  module Bot
    # Monkey patching for Webhooks
    class Client
      def listen(request, &block)
        logger.info('Starting bot')
        fetch_updates(request, &block)
      end

      def fetch_updates(request)
        request = [JSON.parse(request)]
        request.each do |data|
          update = Types::Update.new(data)
          @offset = update.update_id.next
          message = extract_message(update)
          log_incoming_message(message)
          yield message
        end
      end
    end
  end
end
