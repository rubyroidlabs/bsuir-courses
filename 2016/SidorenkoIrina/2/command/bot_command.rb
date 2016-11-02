require_relative 'chat_history'

class Command 
   attr_accessor :bot, :message_chat_id, :text
   def send_message(message_chat_id, text)
       bot.api.sendMessage(chat_id: message_chat_id, text: text)
   end

   def read_file(file_name)
       ChatHistory.new(@message_chat_id, file_name).read_from_file
   end
end
