require 'telegram/bot'
require_relative 'parse/imdb_parser'

token = '426122921:AAGfnHuu4lMTjJehuj6m0h2n9zBkQyrX6dE'
hash = IMDBParser.new.names_orientation

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    if hash.include?(message.text)
      bot.api.send_message(chat_id: message.chat.id, text: 'Yes')
    else
      bot.api.send_message(chat_id: message.chat.id, text: 'No')
    end
  end
end
