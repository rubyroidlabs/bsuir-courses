require_relative 'bot_command'
require_relative 'chat_history'

class ResetCommand < Command
     attr_accessor :bot, :message_chat_id, :text
     @@text ="\xF0\x9F\x98\x94 Хорошо, я забуду все, что между нами было..."

     def initialize (bot, message_chat_id)
	@bot = bot
	@message_chat_id = message_chat_id
     end	
    	
     def reset
	ChatHistory.new(message_chat_id, "reset").delete_directory
	send_message(@@text)
     end

     def send_message(text) 
	super(message_chat_id, text)
     end
end
