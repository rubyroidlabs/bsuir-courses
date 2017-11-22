require 'telegram/bot'
require './lib/message_sender'
require './lib/translator'

TOKEN = 'mybottoken'.freeze

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    options = { bot: bot, message: message }
    MessageResponder.new(options).respond
  end
end
