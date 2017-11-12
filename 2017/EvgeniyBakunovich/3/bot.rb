require 'telegram/bot'
require 'json'

def get_answer(name)
  celebrities = JSON.parse(File.open('Data.txt', &:read))
  celebrities[name]
end

token = ENV['TELEGRAM_TOKEN']
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    answer = get_answer(message.text)
    if message.text == '/start'
      answer =  'Hello! I am ready to work!'
      bot.api.sendMessage(chat_id: message.chat.id, text: answer)
    elsif answer.nil?
      answer = 'No info'
      bot.api.sendMessage(chat_id: message.chat.id, text: answer)
    else
      bot.api.sendMessage(chat_id: message.chat.id, text: answer)
    end
  end
end
