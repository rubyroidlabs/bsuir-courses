require_relative 'bot_command'
require_relative 'chat_history'
require 'date'

class SemesterCommand < Command
     attr_accessor :bot, :message_chat_id, :text
     @@text_begin = "\xF0\x9F\x93\x85 Когда начинаем учиться? "
     @@text_end = "\xF0\x9F\x93\x85 Когда необходимо сдать все лабы?"

     def initialize (bot, message_chat_id)
	@bot = bot
        @message_chat_id = message_chat_id
     end	

     def check_date(date)
	date_hash = Date._parse(date.to_s)
	if(Date.valid_date?(date_hash[:year].to_i, date_hash[:mon].to_i, date_hash[:mday].to_i))
	     return Date.parse(date)
	else 
	     return false
	end
     end

     def period(month, days)	
         send_message("\xE2\x8F\xB3 Ок, на все про все у нас #{month} мес. и #{days} д.")
     end

    def date_comparison(date_begin, date_end, flag)
    	days = (date_end - date_begin).to_i
    	check = date_end - Date.today
	    month = days/30
	    if flag == 0
		if (days < 0 || check < 0)  
	            send_message("Семестр уже закончился или еще не начался!")
	            set_semester
		elsif month != 0
		    period(month, days % 30)
		else 
		    period(month, days)	   
		end
		end
	 return days
     end

     def read_file(file)
     	 super(file)
     end

     def percentage_days
    	 sem = read_file("semester")
         date_start =  Date.parse(sem[0][0])
         date_end =  Date.parse(sem[0][1])
    	 days = date_comparison(date_start, date_end, 1)
    	 cur = Date.today - date_start
    	 percentage_days = ((cur/days)*100).to_f
    	 return percentage_days
     end	

     def save_semester(date_begin, date_end)
     	 ChatHistory.new(@message_chat_id, "semester").save_to_file(date_begin, date_end)
     end
    	
     def set_semester
         counter = 0
	 @text = @@text_begin
	 send_message(@text)
	 bot.listen do |message|	
	     date = check_date(message.text)
	     if (date == false)	
		 send_message(@text)
	     elsif (counter == 0)
		 @date_begin = date
		 @text = @@text_end
		 send_message(@text)
		 counter = counter.next
	     else 
		 @date_end = date
		 break
	     end
	 end
	 date_comparison(@date_begin, @date_end, 0)
	 save_semester(@date_begin, @date_end)
     end

     def send_message(text) 
	 super(message_chat_id, text)
     end
end
