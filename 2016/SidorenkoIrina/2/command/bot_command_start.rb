require_relative 'bot_command'
require_relative 'chat_history'
require 'telegram/bot'

class StartCommand < Command
    attr_accessor :bot, :message_chat_id, :text
	 
    def initialize (bot, message_chat_id, first_name)
       @bot = bot
       @message_chat_id = message_chat_id
       @first_name = first_name
       @text = "Привет, #{@first_name}\xF0\x9F\x98\xBA 
Я тебе смогу помочь сдать все лабы, чтобы мамка не ругалась. Вот что я умею: 
\xE2\x9C\x85 /start - начало работы
\xE2\x9C\x85 /semester -  запомню начало и конец семестра
\xE2\x9C\x85 /subject - запомню предмет и количество лабораторных
\xE2\x9C\x85 /submit - запомню какие лабы ты сдал
\xE2\x9C\x85 /status - покажу список лаб, которые тебе предстоит сдать
\xE2\x9C\x85 /reset - забуду тебя"
    end	
   		
    def create_dir
   	ChatHistory.new(message_chat_id, "start").create_directory
    end

    def send_message 
        create_dir
        super(@message_chat_id, @text)	
    end
end
