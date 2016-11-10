# Class for basic @@bot actions
class Bot < BotServer
  def database_save(chat_id, user)
    DATABASE.set(chat_id, user.to_json)
  end

  def run(request)
    bot do |bot|
      bot_command_handler = BotCommandHandler.new
      bot.listen(request) do |update|
        bot_command_handler.process(update)
      end
    end
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
    bot { |bot| bot.api.send_message(chat_id: chat_id, text: text, reply_markup: reply_markup) }
  end

  def update
    bot { |bot| bot.fetch_updates { |message| yield(message) if block_given? } }
  end

  def listen
    bot { |bot| bot.listen { |message| yield(message) if block_given? } }
  end
end
