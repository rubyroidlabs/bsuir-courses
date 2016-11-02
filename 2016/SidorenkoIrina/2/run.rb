require 'telegram/bot'
require './command/bot_command_start'
require './command/bot_command_semester'
require './command/bot_command_subject'
require './command/bot_command_reset'
require './command/bot_command_status' 
require './connection'



Telegram::Bot::Client.run(Connection.new.get_token) do |bot|
    bot.listen do |message|
        case message.text
        when '/start', 'привет', 'Привет'     	  
             StartCommand.new(bot, message.chat.id, message.from.first_name).send_message  
        when '/semester'
            SemesterCommand.new(bot, message.chat.id).set_semester           
        when '/status'
            StatusCommand.new(bot, message.chat.id).status    
        when '/subject'
            SubjectCommand.new(bot, message.chat.id).set_subject
        when '/reset'
            ResetCommand.new(bot, message.chat.id).reset  
        end
    end
end