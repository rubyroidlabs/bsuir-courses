require_relative 'parser'
require 'fuzzy_match'
require 'translit'

#
class MessageHandler
  def call_answer_start(bot, message)
    bot.api.send_message(
      chat_id: message.chat.id,
      text: "Здравствуйте, #{message.from.first_name}"
    )
  end

  def call_answer_update(bot, message)
    bot.api.send_message(
      chat_id: message.chat.id,
      text: 'База данных начала обновляться, это может занять некоторое время'
    )
    Parser.new.write_data
    bot.api.send_message(
      chat_id: message.chat.id,
      text: 'База данных обновлена'
    )
  end

  def call_answer_stop(bot, message)
    bot.api.send_message(
      chat_id: message.chat.id,
      text: "До свидания, #{message.from.first_name}"
    )
  end

  def call_answer_name(bot, message, data)
    result = data.select { |t| t['name'].downcase == message.text.downcase }
    if result.empty? == false
      bot.api.send_message(chat_id: message.chat.id, text: "Да\n
      #{result[0]['description']}\n\n#{result[0]['orientation']}")
    elsif (name = find_similar(data, message.text))
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Нет, возможно вы имели ввиду #{name}"
      )
    else
      bot.api.send_message(
        chat_id: message.chat.id,
        text: 'Нет'
      )
    end
  end

  def find_similar(data, name)
    names = []
    data.each { |temp| names << temp['name'] }
    FuzzyMatch.new(names).find(Translit.convert(name, :english))
  end
end
