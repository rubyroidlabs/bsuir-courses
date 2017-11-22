require 'mechanize'
require 'json'
require 'translit'
require 'languager'

class CorrectInput
  attr_reader :bot
  attr_reader :message_main

  def initialize(message, bot)
    @bot = bot
    @message_main = message
  end

  def what_language
    bot.api.send_message(
      chat_id: message_main.chat.id,
      text: 'Вы корректно написали ваш запрос?'
      )
    bot.listen do |message|
      case message.text
      when 'Да'
        break
      when 'Нет'
        bot.api.send_message(
          chat_id: message_main.chat.id,
          text: 'На каком языке вы хотели написать?'
          )
        bot.listen do |message|
          case message.text
          when 'Русский'
            correct_input_to_russian
            break
          when 'Английский'
            correct_input_to_english
            break
          end
        end
      end
      break
    end
  end

  def correct_input_to_english
    bot.api.send_message(
      chat_id: message_main.chat.id,
      text: 'Ошиблись раскладкой клавиатуры, но писали по-английски?'
      )
    bot.listen do |message|
      case message.text
      when 'Да'
        Translit.convert(message_main.text)
        break
      when 'Нет'
        gogel_translate('ru', 'en', message_main.text)
        break
      end
    end
  end

  def correct_input_to_russian
    bot.api.send_message(
      chat_id: message_main.chat.id,
      text: 'Ошиблись раскладкой клавиатуры, но писали по-русски?'
      )
    bot.listen do |message|
      case message.text
      when 'Да'
        Translit.convert(message_main.text)
        break
      when 'Нет'
        gogel_translate('en', 'ru', message_main.text)
        break
      end
    end
  end

  def gogel_translate(sour, targ, txt)
    agent = Mechanize.new
    apikey = 'myapikey'
    source = sour
    target = targ
    page = agent.get "https://www.googleapis.com/language/translate/v2?key=#{
                      apikey}&source=#{source}&target=#{target}&q=#{txt}"
    js = JSON.parse(page.body)
    js['data']['translations'][0]['translatedText']
  end
end
