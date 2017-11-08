require 'telegram/bot'
require 'translit'
require_relative 'orientation'

class Bot
	def initialize(token) 
		@token = token
	end

	def start
		Telegram::Bot::Client.run(@token) do |bot|
		  bot.listen do |message|
		  	if message.text.split.size == (1 || 0)
		  		status = clarify_full_name(bot, message)
		  	elsif message.text.scan(/[А-Яа-я]/).size > 0
		  		status = clarify_language(bot, message)
		  	else
			    status = Orientation.by_full_name(message.text)
			  end
			  if status.nil?
			  	bot.api.sendMessage(chat_id: message.chat.id, text: "Нет данных")
			  else
			  	bot.api.sendMessage(chat_id: message.chat.id, text: status)
			  end
		  end
		end
	end

	def clarify_full_name(bot, message)
		correct_name = Orientation.find_full_name(message.text)
		if correct_name.nil?
			nil
		else
			bot.api.sendMessage(chat_id: message.chat.id, text: "#{correct_name}?")
			decide(bot, correct_name)
		end
	end

	def clarify_language(bot, message)
		correct_name = Translit.convert(message.text)
		bot.api.sendMessage(chat_id: message.chat.id, text: "#{correct_name}?")
		decide(bot, correct_name)
	end

	def decide(bot, correct_name)
		bot.listen do |message|
		  if message.text == 'Да'
		  	return Orientation.by_full_name(correct_name)
		  end
		end
	end
end

tattler = Bot.new('475450456:AAEyFd-U2j2LUDoCGgCb017oxx1BDKC9gw0')
tattler.start