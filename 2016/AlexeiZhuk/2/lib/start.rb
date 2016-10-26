require 'redis'

class Start 
	
	def step1
		start_semester  = message.text	
		bot.api.sendMessage(chat_id: message.chat.id, text: "начинаем, #{start_semester} Когда надо сдать все лабы?")
		current_step = 2
	end

	def step2
		bot.api.sendMessage(chat_id: message.chat.id, text: "сдаем все лабы #{message.text} числа")
	end
end		