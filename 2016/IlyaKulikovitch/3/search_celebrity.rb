require 'translit'
require_relative 'message_responder'
class SearchCelebrity
  attr_reader :flag_data

  def initialize(bot, message)
    @bot = bot
    @message = message
    @flag_data = false
  end

  def ob_msg_responder
    responder_info = { bot: @bot, message: @message }
    MessageResponder.new(responder_info)
  end

  def search_star(star, text)
    message_responder = ob_msg_responder
    if star.key?(text) || star.key?(Translit.convert(text))
      message_responder.answer_with_message('Да')
      text = Translit.convert(text, :english)
      if !star[text].nil?
        message_responder.answer_with_message(star[text])
      else
        message_responder.answer_with_message('Отсвутствует описание')
      end
    else
      message_responder.answer_with_message('Не найдено данных')
      @flag_data = true
    end
  end
end
