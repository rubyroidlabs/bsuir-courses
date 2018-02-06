require 'telegram/bot'
require_relative 'message_responder'
require_relative 'message_sender'
require_relative 'search_celebrity'
require_relative 'parser'
require_relative 'read_celebrity'
BASA = 'base.json'.freeze
TOKEN = '484729034:AAHbd9R-1uS6ZyrzXeHB4Mx3RrqdDkUf8d4'.freeze
pars = Parser.new(BASA)
pars.run_parser
star = ReadCelebrity.new(BASA)
star.write_to_base
found_stars = {}
element = ''
a = ''
Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    search = SearchCelebrity.new(bot, message)
    msg_responder = search.ob_msg_responder
    case message.text
    when '/start'
      msg_responder.start
    when '/stop'
      msg_responder.stop
    when 'yes'
      unless star.celebrity[element].nil?
        msg_responder.answer_with_message(star.celebrity[element])
      end
      found_stars = {}
    when 'no'
      answer_no
    when /[а-яА-ЯA-Za-z]+/
      a = message.text
      search.search_star(star.celebrity, a)
      exist_found_star
    end
  end
end

def exist_found_star
  if search.flag_data
    star.celebrity.each do |key, value|
      if key.to_s =~ /#{a}/
        found_stars[key] = value
        element = key
      end
    end
    unless found_stars.empty?
      msg_responder.answer_with_message("Возможно #{element}?")
    end
  else
    msg_responder.question
  end
end

def answer_no
  found_stars.delete(element)
  if !found_stars.empty?
    found_stars.each_key do |key|
      element = key
    end
    msg_responder.answer_with_message("Возможно #{element}?")
  else
    msg_responder.answer_with_message('Неудача, где-то ошибся. Пробуй еще!')
    found_stars = {}
  end
end
