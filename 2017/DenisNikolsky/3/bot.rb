require 'telegram/bot'
require 'json'

class Bot
  def initialize
    @token = ENV['TELEGRAM_TOKEN']
  end

  def start
    Telegram::Bot::Client.run(@token) do |bot|
      bot.listen do |message|
        answer = send_answer(message.text)
        if answer.nil?
          text = 'information about this person is classified'
          bot.api.sendMessage(chat_id: message.chat.id, text: text)
        else
          bot.api.sendMessage(chat_id: message.chat.id, text: answer)
        end
      end
    end
  end

  def send_answer(name)
    celeb = JSON.parse(File.open('celebrities', &:read))
    celeb[name]
  end
end

bot = Bot.new
bot.start
