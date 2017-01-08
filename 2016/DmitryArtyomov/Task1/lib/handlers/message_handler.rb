# Class for handling incoming messages
class MessageHandler
  attr_reader :bot, :action_handler

  def initialize(bot)
    @bot = bot
    @action_handler = ActionHandler.new(self)
  end

  def handle(message)
    return unless valid_message?(message)
    return if waiting_for_input?(message)

    CommandDispatcher.new(message, self, action_handler)
  end

  def send_message(chat_id, text)
    bot.api.send_message(
      chat_id: chat_id,
      text: text,
      parse_mode: 'Markdown'
    )['result']['message_id']
  rescue Telegram::Bot::Exceptions::ResponseError
    nil
  end

  def send_message_inline(chat_id, text, markup)
    bot.api.send_message(
      chat_id: chat_id,
      text: text,
      parse_mode: 'Markdown',
      reply_markup: markup
    )['result']['message_id']
  rescue Telegram::Bot::Exceptions::ResponseError
    nil
  end

  def edit_inline_message(chat_id, msg_id, text, markup = nil)
    bot.api.edit_message_text(
      chat_id: chat_id,
      message_id: msg_id,
      text: text,
      parse_mode: 'Markdown'
    )['result']['message_id']

    edit_inline_markup(chat_id, msg_id, markup) unless markup.nil?
  rescue Telegram::Bot::Exceptions::ResponseError
    nil
  end

  private

  def waiting_for_input?(message)
    user = User.new(message.chat.id)

    if callback?(user, message)
      true
    elsif user.action?
      action_handler.handle(message)
      true
    else
      false
    end
  end

  def callback?(user, message)
    # Second part is fix for users who can't do anything if bot waits for
    # a callback, but message history was cleared
    if user.callback? && !(message.text =~ %r{/cancel})
      send_message(message.chat.id, Responses::WAIT_FOR_CALLBACK)
      true
    else
      false
    end
  end

  def valid_message?(message)
    # Ignore messages without any text
    return false unless message.text
    # Ignore message edits
    return false if message.edit_date
    true
  end

  def edit_inline_markup(chat_id, msg_id, markup)
    bot.api.edit_message_reply_markup(
      chat_id: chat_id,
      message_id: msg_id,
      reply_markup: markup
    )['result']['message_id']
  end
end
