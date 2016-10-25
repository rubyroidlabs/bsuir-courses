class Bot1

require 'telegram/bot'
require_relative 'lib/start.rb'
require 'redis'

token = '294067493:AAHPs01T5fsg10uTytdQDcJFzVzf8XNeRNs'
HELP='Привет. Я тебе смогу помочь сдать все лабы, чтобы мамка не ругалась. Смотри список что я умею:
/semester - запоминает даты начала и конца семестра
/subject - добавляет предмет и количество лабораторных работ по нему
/status - выводит твой список лаб, которые тебе предстоит сдать
/reset - сбрасывает для пользователя все данные.'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    	
    when '/start'
     	bot.api.sendMessage(chat_id: message.chat.id, text: HELP)
	when '/semester'	
    	bot.api.sendMessage(chat_id: message.chat.id, text: "Когда начинаем учиться?")
    	bot.listen(message.text) 
    	bot.api.sendMessage(chat_id: message.chat.id, text: "Когда надо сдать все лабы?")
    	bot.listen(message.text)
    	bot.api.sendMessage(chat_id: message.chat.id, text: "начинаем, #{start_semester} заканчиваем #{end_semester}")
    	
    when '/subject'
    	bot.api.sendMessage(chat_id: message.chat.id, text: "subject, #{message.from.first_name}")
    end
    	 
  end
end
end