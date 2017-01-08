# bot
class Bot
  def initialize(bot, message)
    @bot = bot
    @message = message
  end

  def send_text_message(text)
    @bot.api.send_message(chat_id: @message.chat.id, text: text) if @bot != "test"
    true
  rescue
    @bot.api.send_message(chat_id: @message.message.chat.id, text: text) if @bot != "test"
    true
  end

  def send_markup_message(text, markup)
    @bot.api.sendMessage(chat_id: @message.chat.id, text: text, reply_markup: markup)
  rescue
    @bot.api.sendMessage(chat_id: @message.message.chat.id, text: text, reply_markup: markup)
  end

  def send_sticker(id)
    @bot.api.sendSticker(chat_id: @message.chat.id, sticker: id)
  end
end
