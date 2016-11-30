require_relative 'bot_command'
require_relative 'chat_history'

class SubjectCommand < Command
    attr_accessor :bot, :message_chat_id, :text
    @@what_subject = "\xF0\x9F\x93\x9A Какой предмет учим? "
    @@how_many_labs = "Сколько лаб надо сдать?"

    def initialize (bot, message_chat_id)
    	@bot = bot
    	@message_chat_id = message_chat_id
    end	

    def save_file(file, subject, labs)
        super(file, subject, labs)
    end
		
    def set_subject
    	counter = 0 
    	send_message(@@what_subject)
    	bot.listen do |message|			
    		if(counter == 0)
    			@subject = message.text
    			send_message(@@how_many_labs)
    		elsif (message.text.to_i.between?(1,15)	)
    			@labs = message.text
    			send_message("\xF0\x9F\x91\x8C OK")		    	
    			break
    		else
    			send_message(@@how_many_labs)
    		end
                counter = counter.next
        end	
        save_file('subject', @subject, @labs)
    end

    def send_message(text) 
        super(message_chat_id, text)
    end
end
