require 'telegram/bot'

# Bot
class TelegramBot
  def initialize(token)
    @token = token
    @actors = {}
  end

  def search_celebrity(bot, message)
    first = Translate.new.translate(message.text.upcase).to_s
    second = message.text.upcase.to_s
    if @actors.key?(first) || @actors.key?(second)
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "#{first}:\n-#{@actors[first]}"
      )
    elsif !@actors.key?(message.text.upcase.to_s)
      bot.api.send_message(
        chat_id: message.chat.id,
        text: 'No data. Please, try one more time.'
      )
    end
  end

  def start
    @actors = JSON.parse(File.read('list.json'))

    Telegram::Bot::Client.run(@token) do |bot|
      bot.listen do |message|
        case message.text
        when '/start'
          bot.api.send_message(
            chat_id: message.chat.id,
            text: "Hello, #{message.from.first_name}!\n"\
            'Enter the name and surname of the actor or actress.'
          )
        when '/stop'
          bot.api.send_message(
            chat_id: message.chat.id,
            text: 'See you again...'
          )
        when message.text
          search_celebrity(bot, message)
        end
      end
    end
  end
end
