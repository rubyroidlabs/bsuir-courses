require 'telegram/bot'
require 'to_lang'
require_relative 'parse/write'

ToLang.start('AIzaSyCZODqWMHOZPYAaWNJ77X-nMzmi4F31_cQ')
token = '426122921:AAGfnHuu4lMTjJehuj6m0h2n9zBkQyrX6dE'
info = Write.new.info

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    answer = message.text.to_english
    if info.include?(answer)
      bot.api.send_message(chat_id: message.chat.id, text: 'Coming out!')
    else
      bot.api.send_message(chat_id: message.chat.id, text: 'Not enough info')
    end
  end
end
