require "redis"
class Base
  attr_accessor :bot, :user_id, :messages_array, :last_message

  def initialize(bot, message_chat_id)
    @bot = bot
    @user_id = message_chat_id
  end

  def telegram_send_message(text, answers = nil)
    if answers.nil?
      @bot.api.send_message(chat_id: @user_id, text: text, parse_mode: 'Markdown')
    else
      @bot.api.send_message(chat_id: @user_id, text: text, parse_mode: 'Markdown', reply_markup: answers)
    end
  end
end
