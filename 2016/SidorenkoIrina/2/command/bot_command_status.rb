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

    def passed_labs(info, labs)
        percentage_days = SemesterCommand.new(@bot, @message_chat_id).percentage_days
        percentage_labs = ((percentage_days/100)*labs).to_f
        num = ""
        for j in 1..percentage_labs.round
            num = num + " #{j}" 
        end
        text =  " #{num} " 
        return text
    end   
    
    def check(info)
        passed = read_file('submit')
        counter=0
        if passed != false
            for i in 0..info.size-1
                for j in 0..passed.size-1
                    if info[i][0] == passed[j][0]
                        counter += 1
                    end
                end 
            end
            return counter 
        end
        return false
    end
    
    def status
        info = read_file('subject')
        lab = read_file('semester')
        counter = check(info)
        all_labs = 0
        unless info
           send_message("Для начала выполните команду /subject")
        else
            unless lab
               send_message("Вы не установили границы семестра! /semester")
            else
                text = "\xF0\x9F\x93\x85 К этому времени у тебя должно быть сдано:\n\n"
                for i in 0..info.size-1 
                    amount = info[i][1].to_i                        
                    all_labs += amount   
                    text = text + "\xF0\x9F\x93\x8C  #{info[i][0]}:" + passed_labs(info, info[i][1].to_i) + "из #{amount}\n"  
                end  
                unless counter 
                  number = all_labs
                else 
                    number = all_labs - counter
                end
                text = text + "\n \xF0\x9F\x94\xA5 Тебе осталось сдать #{number} лаб из #{all_labs}.\n Не грусти, лето уже скоро. \xF0\x9F\x8F\x84"
                send_message(text) 
            end
        end
    end

    def send_message(text) 
        super(message_chat_id, text)
    end
end
