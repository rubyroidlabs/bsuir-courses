require 'telegram/bot'
require './command/bot_command_start'
require './command/bot_command_semester'
require './command/bot_command_subject'
require './command/bot_command_reset'
require './command/bot_command_status' 
require './command/bot_command_submit' 
require './connection'

Telegram::Bot::Client.run(Connection.new.get_token) do |bot|
    bot.listen do |message|
        if message.class == Telegram::Bot::Types::Message          
            case message.text
            when '/start', 'привет', 'Привет'     	  
                StartCommand.new(bot, message.chat.id, message.from.first_name).send_message  
            when '/semester'
                SemesterCommand.new(bot, message.chat.id).set_semester           
            when '/status'
                StatusCommand.new(bot, message.chat.id).status    
            when '/subject'
                SubjectCommand.new(bot, message.chat.id).set_subject
            when '/submit', 'я сдал', 'я сдала', 'сдал', 'сдала', 'Сдал', 'Сдала', 'Я сдал', 'Я сдала' 
                SubmitCommand.new(bot, message.chat.id).submit
            when '/reset'
                ResetCommand.new(bot, message.chat.id).reset
            end
        elsif message == Telegram::Bot::Types::CallbackQuery
            SubmitCommand.new(bot, message.chat.id).submit
        end 
    end
end
