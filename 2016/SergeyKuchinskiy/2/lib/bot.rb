# bot
class Bot
  def initialize(bot, message)
    @bot = bot
    @message = message
  end

  def send_text_message(text)
    begin
      @bot.api.send_message(chat_id: @message.chat.id, text: text)
    rescue
      @bot.api.send_message(chat_id: @message.message.chat.id, text: text)
    end
  end

  def send_markup_message(text, markup)
    begin
      @bot.api.sendMessage(chat_id: @message.chat.id, text: text, reply_markup: markup)
    rescue
      @bot.api.sendMessage(chat_id: @message.message.chat.id, text: text, reply_markup: markup)
    end
  end

  def send_sticker(id)
    @bot.api.sendSticker(chat_id: @message.chat.id, sticker: id)
  end
end
