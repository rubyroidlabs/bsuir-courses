require_relative 'parser'
require 'telegram/bot'
require 'mechanize'
require 'translit'
require 'gingerice'

token = '489305805:AAELYgWpTBkzfJcA0WUzYnCWCrPeg9tLKyk'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
      when '/start'
      bot.api.sendMessage(chat_id: message.chat.id, 
                          text: "Hello, #{message.from.first_name}")
      when '/stop'
      bot.api.sendMessage(chat_id: message.chat.id, text: 'While my hero')
      else
      parser = Parser.new Translit.convert(message.text.to_s, :english)
      if  parser.search_in_gay_actors ||
          parser.search_in_bisexual_actors ||
          parser.search_in_lesbian_actors
        bot.api.sendMessage(chat_id: message.chat.id, text: parser.print)
        else
        bot.api.sendMessage(chat_id: message.chat.id, 
                            text: 'This person is not in this list')
      end
    end
  end
end
