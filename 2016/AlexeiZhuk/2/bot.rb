
require 'byebug'
require 'telegram/bot'
require_relative 'lib/redis.rb'
require_relative 'lib/start.rb'
require 'redis'

	token = '294067493:AAHPs01T5fsg10uTytdQDcJFzVzf8XNeRNs'
	HELP='Привет. Я тебе смогу помочь сдать все лабы, чтобы мамка не ругалась. Смотри список что я умею:
	/semester - запоминает даты начала и конца семестра
	/subject - добавляет предмет и количество лабораторных работ по нему
	/status - выводит твой список лаб, которые тебе предстоит сдать
	/reset - сбрасывает для пользователя все данные.'
	current_dialog = ''
	current_step = 0 
	dialogs = ['/start', '/semester', '/subject' ]

	Telegram::Bot::Client.run(token) do |bot|
	  bot.listen do |message|
	     
	  	if dialogs.include? message.text 
	  	#eval('mybot::mess::#{message.text[1..-1].capitalize}').new('message')	
		    case message.text
		    when '/start'
		     	bot.api.sendMessage(chat_id: message.chat.id, text: HELP)
		    	current_dialog = '/start'
				when '/semester'
		    	bot.api.sendMessage(chat_id: message.chat.id, text: "Когда начинаем учиться?")
		    	current_dialog = '/semester'
		    when '/subject'
		    	bot.api.sendMessage(chat_id: message.chat.id, text: "Какой предмет учим?")
		    	current_dialog = '/subject'
		    when '/status'
		    end
		    current_step = 1
	  	else
				case current_dialog
				when '/semester' 
		  		case current_step 
		  		when 1 
			  		start_semester = message.text	
			    	bot.api.sendMessage(chat_id: message.chat.id, text: "начинаем, #{start_semester} Когда надо сдать все лабы?")
		    		current_step = 2
					when 2
						bot.api.sendMessage(chat_id: message.chat.id, text: "сдаем все лабы #{message.text} числа")
					end
				when '/subject'
					case current_step 
		  		when 1
		  			subject=message.text
		    		bot.api.sendMessage(chat_id: message.chat.id, text: "Предмет #{subject} Сколько лаб надо сдать?")
		    		current_step = 2
		 			when 2
		    		bot.api.sendMessage(chat_id: message.chat.id, text: "лаб #{message.text}")
		 			end
		 		end
	  	end
		end
	end

