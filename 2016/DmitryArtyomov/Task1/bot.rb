require 'telegram/bot'
require 'require_all'
require_all 'lib'

Telegram::Bot::Client.run(Secret::TELEGRAM_TOKEN) do |bot|
  message_handler = MessageHandler.new(bot)
  callback_handler = CallbackHandler.new(message_handler)
  bot.listen do |data|
    case data
    when Telegram::Bot::Types::CallbackQuery
      callback_handler.handle(data)
    when Telegram::Bot::Types::Message
      message_handler.handle(data)
    end
  end
end
