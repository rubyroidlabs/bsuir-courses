# Class for basic Bot actions
class Bot
  attr_reader :bot, :database

  def initialize(bot, database)
    @@bot = bot
    @@database = database
  end

  def database_save(chat_id, user)
    @@database.set(chat_id, user.to_json)
  end

  def database_load(chat_id)
    user = @@database.get(chat_id) || {}
    if user.is_a?(String)
      JSON.parse(user).keys_to_syms
    else
      {}
    end
  end

  def send_message(chat_id: "", text: "", reply_markup: "")
    @@bot.api.send_message(chat_id: chat_id, text: text, reply_markup: reply_markup)
  end

  def update
    @@bot.fetch_updates { |message| yield(message) if block_given? }
  end

  def listen
    @@bot.listen { |message| yield(message) if block_given? }
  end
end
