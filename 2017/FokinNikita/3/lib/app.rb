require 'telegram/bot'
require_relative 'parser/parser'
require_relative 'db/db'

TOKEN = '485917499:AAGbkCzzaf3ZPcsO1NOg03NQ-t11zEGilns'.freeze
Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message
    when Telegram::Bot::Types::CallbackQuery
      if message.data == 'entername'
        user = Parser::Wiki.new
        bot.listen do |name|
          user.parse(name)
          if !user.celebrity[:ORINTATION].nil?
            puts "#{user.celebrity[:NAME] - user.celebrity[:ORINTATION]}"
          end
          puts 'info in wiki not found'
          user = Parser::Imdb.new
          user.parse(name)
          if !user.celebrity[:ORINTATION].nil?
            puts "#{user.celebrity[:NAME] - user.celebrity[:ORINTATION]}"
          end
          puts 'info in imdb not found'
          break
        end
    when Telegram::Bot::Types::Message
      kb = [
        Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Enter Name', callback_data: 'entername')
      ]
      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      bot.api.send_message(chat_id: message.chat.id, text: 'Make a choice', reply_markup: markup)
    end
  end
end
