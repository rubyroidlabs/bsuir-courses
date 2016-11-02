require_relative 'bot_command'
require_relative 'bot_command_semester'
require_relative 'chat_history'

class StatusCommand < Command
	attr_accessor :bot, :message_chat_id, :text

	def initialize (bot, message_chat_id)
		@bot = bot
		@message_chat_id = message_chat_id
    end	

    def read_file(file)
    	super(file)
    end
    	
    def passed_labs(info, all_labs)
        percentage_days = SemesterCommand.new(@bot, @message_chat_id).percentage_days
        percentage_labs = ((percentage_days/100)*all_labs).to_f
        for i in 0..info.size-1
            labs = info[i][1].to_i
            num = ""
            result =  labs*(percentage_labs/100)
            for j in 1..result.round
                num = num + " #{j}"
            end
            text =  " #{num} "  
        end
        return text
    end   
    
    def status
    	info = read_file('subject')
        lab = read_file('semester')
        unless info
            send_message("Для начала выполните команду /subject")
        else
            unless lab
                send_message("Вы не установили границы семестра! /semester")
            else
                all_labs = 0
                text = "\xF0\x9F\x93\x85 К этому времени у тебя должно быть сдано:\n\n"
        	   	for i in 0..info.size-1 
                    amount = info[i][1].to_i
                    all_labs += amount   
                    text = text + "\xF0\x9F\x93\x8C  #{info[i][0]}:" + passed_labs(info, all_labs) + "из #{amount}\n"  
                end  
                text = text + "\n Не грусти, лето уже скоро. \xF0\x9F\x8F\x84"
                send_message(text)
            end
        end
	end

    def send_message(text) 
		super(message_chat_id, text)
	end
end
