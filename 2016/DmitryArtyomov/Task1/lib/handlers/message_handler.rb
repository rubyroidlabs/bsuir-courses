# Class for handling incoming messages
class MessageHandler
  attr_reader :bot, :action_handler

  def initialize(bot)
    @bot = bot
    @action_handler = ActionHandler.new(self)
  end

  def handle(message)
    return unless message.text
    return if message.edit_date
    user = User.new(message.chat.id)
    return if user.callback?
    if user.action?
      action_handler.handle(message)
    else
      CommandDispatcher.new(message, self, action_handler)
    end
  end

  def send_message(chat_id, text)
    bot.api.send_message(
      chat_id: chat_id,
      text: text,
      parse_mode: 'Markdown'
    )
  end

  def send_message_inline(chat_id, text, markup)
    bot.api.send_message(
      chat_id: chat_id,
      text: text,
      parse_mode: 'Markdown',
      reply_markup: markup
    )
  end

  def edit_inline_message(chat_id, msg_id, text, markup = nil)
    bot.api.edit_message_text(
      chat_id: chat_id,
      message_id: msg_id,
      text: text,
      parse_mode: 'Markdown'
    )

    edit_inline_markup(chat_id, msg_id, markup) unless markup.nil?
  end

  private

  def edit_inline_markup(chat_id, msg_id, markup)
    bot.api.edit_message_reply_markup(
      chat_id: chat_id,
      message_id: msg_id,
      reply_markup: markup
    )
  end
end
