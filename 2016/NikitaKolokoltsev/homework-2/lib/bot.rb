# Class for basic Bot actions
class Bot
  def initialize(bot, database)
    BOT = bot
    DATABASE = database
  end

  def database_save(chat_id, user)
    DATABASE.set(chat_id, user.to_json)
  end

  def database_load(chat_id)
    user = DATABASE.get(chat_id) || {}
    if user.is_a?(String)
      JSON.parse(user).keys_to_syms
    else
      {}
    end
  end

  def send_message(chat_id: "", text: "", reply_markup: "")
    BOT.api.send_message(chat_id: chat_id, text: text, reply_markup: reply_markup)
  end

  def update
    BOT.fetch_updates { |message| yield(message) if block_given? }
  end

  def listen
    BOT.listen { |message| yield(message) if block_given? }
  end
end
