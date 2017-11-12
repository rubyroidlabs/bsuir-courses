require 'telegram/bot'
require_relative 'artist'

BOT_TOKEN = '472561745:AAH8IkGRDsLDCot4_QISoiMSLWo3YgYO-Mw'.freeze

Artist.load_from_sites

Telegram::Bot::Client.run(BOT_TOKEN) do |bot|
  bot.listen do |message|
    case message
    when Telegram::Bot::Types::Message
      case message.text
      when '/start'
        bot.api.send_message(chat_id: message.chat.id, text: "Привет, #{message.from.first_name}, я камминг-аут бот, введи имя своего артиста, чтобы я смог его проверить. ")
      when '/stop'
        bot.api.send_message(chat_id: message.chat.id, text: "Пока, #{message.from.first_name}, рад был помочь. Приходи еще ")
      else
        if artist = Artist.find_by_name(message.text)
          if artist.name == message.text
            bot.api.send_message(chat_id: message.chat.id, text: "#{artist.name}:\n #{artist.description}")
          else
            keyboard = [
              Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Да', callback_data: artist.name),
              Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Нет', callback_data: 'Нет')
            ]
            markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: keyboard)
            bot.api.send_message(chat_id: message.chat.id, text: "Возможно Вы имели ввиду #{artist.name}?", reply_markup: markup)
          end
        else
          bot.api.send_message(chat_id: message.chat.id, text: 'Нет такого артиста в базе')
        end
      end
    when Telegram::Bot::Types::CallbackQuery
      if message.data == 'Нет'
        bot.api.send_message(chat_id: message.from.id, text: 'Попробуйте еще раз или введите другого артиста')
      else
        artist = Artist.find_by_name(message.data)
        bot.api.send_message(chat_id: message.from.id, text: "#{artist.name}:\n #{artist.description}")
      end
    end
  end
end
