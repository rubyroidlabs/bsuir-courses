class Start
  def initialize(bot, message)
    @bot = bot
    @message = message
  end

  def menu
    bot_text = "Hello, dear #{@message.from.first_name}.\nEnter the name:"
    @bot.api.send_message(chat_id: @message.from.id, text: bot_text)
  end

  def self.preprocess(file)
    CSV.read(file, headers: false)
  end
end
