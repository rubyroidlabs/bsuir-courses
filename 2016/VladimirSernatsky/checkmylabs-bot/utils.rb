require 'telegram/bot'

require_relative 'session'

InlineKeyboardMarkup = Telegram::Bot::Types::InlineKeyboardMarkup
InlineKeyboardButton = Telegram::Bot::Types::InlineKeyboardButton

# common methods
module Utils
  def self.send_promt(api, answer)
    Session.set('__promt__', answer.var)
    api.send_message chat_id: Session.id, text: answer.message
  end

  def self.send_keyboard(api, answer)
    api.send_message chat_id: Session.id,
                     text: answer.message,
                     reply_markup: InlineKeyboardMarkup.new(
                       inline_keyboard: answer.keyboard
                     )
  end

  def self.send_answer(api, answer)
    case answer
    when Promt then send_promt api, answer
    when Keyboard then send_keyboard api, answer
    when String then api.send_message chat_id: Session.id, text: answer
    end
  end

  def self.send_query_answer(api, query_id, answer)
    api.answer_callback_query callback_query_id: query_id
    send_answer api, answer
  end

  def self.handle_message(api, handler, message)
    answer = handler.handle message.from, Session.request
    if answer.is_a? Array
      answer.each { |a| send_answer api, a }
    else
      send_answer api, answer
    end
  end

  def self.handle_query(api, handler, message)
    answer = handler.handle message.from, Session.request
    if answer.is_a? Array
      answer.each do |a|
        send_query_answer api, message.id, a
      end
    else
      send_query_answer(api, message.id, answer)
    end
  end

  def self.something_wrong(api)
    api.send_message(
      chat_id: Session.id,
      text: "Ты сломал меня.\nМои поздравления."
    )
  end
end

# responce class for request value of variable
class Promt
  attr_reader :message, :var
  def initialize(message, var)
    @message = message
    @var = var
  end
end

# responce class for send inline-keyboard
class Keyboard
  attr_reader :message, :keyboard
  def initialize(message)
    @message = message
    @keyboard = []
  end

  def add_button(text, data)
    @keyboard << InlineKeyboardButton.new(
      text: text, callback_data: data
    )
    self
  end
end
