require 'telegram/bot'
require_relative 'bot_command'
require_relative 'chat_history'

class SubmitCommand < Command
    attr_accessor :bot, :message_chat_id, :text

    def initialize (bot, message_chat_id)
	@bot = bot
        @message_chat_id = message_chat_id
    end	

    def read_file(file_name)
        super(file_name)
    end
    	
    def send(markup, text)
        bot.api.send_message(chat_id: @message_chat_id, text: text, reply_markup: markup)
    end

    def save_file(file_name,subject, lab)   
        super(file_name, subject, lab)
    end

    def get_array_labs(sub, labs)
        array=[]
        for i in 1..labs.to_i 
            array.push(i)
        end
        return array
    end

    def check_submit(sub, labs)
        passed = read_file('submit')
        counter = 0
        button = []
        if passed != false 
            arr_labs_sub = get_array_labs(sub, labs)
            for z in 0..passed.size-1
                if sub == passed[z][0]
                    arr_labs_sub.delete(passed[z][1].to_i)
                    counter += 1 
                end
            end 
            for i in 0..arr_labs_sub.size-1
                button.push(Telegram::Bot::Types::InlineKeyboardButton.new(text: arr_labs_sub[i], callback_data: arr_labs_sub[i]))
            end  
        end
        if counter == 0 || passed == false
            for x in 1..labs.to_i              
                button.push(Telegram::Bot::Types::InlineKeyboardButton.new(text: x, callback_data: x))
            end
        end
        return button
    end

    def submit  
        subject=[]
        button=[]
        labs=[] 
        info = read_file('subject')
        unless info
            send_message("Для начала выполните команду /subject")
        else
            unless read_file('semester')
               send_message("Вы не установили границы семестра! /semester")
        else	    
            for i in 0..info.size-1 
                subject.push(info[i][0])
                labs.push(info[i][1])
            end
            for i in 0..subject.size-1 
                button.push(Telegram::Bot::Types::InlineKeyboardButton.new(text: subject[i], callback_data: subject[i]))
            end
            markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: button)
            send(markup, "Что сдавал(а)?")
            count = 0
            bot.listen do |message|
            	if message.class == Telegram::Bot::Types::CallbackQuery
            	    for k in 0..subject.size-1
                        if message.data == subject[k]
                            mark = check_submit(subject[k], labs[k])
                            m = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: mark)
                            send(m, "Какую лабу?")
			elsif message.data.to_i.between?(1,labs[k].to_i) 
			      send_message("\xF0\x9F\x91\x8F Ты сдал(а) #{message.data.to_i} лабу по #{subject[k]}. Красавчег!")
			      save_file('submit', subject[k], message.data.to_i)
			      return 
			end
		    end
                end
            end
        end
    end
    end

    def send_message(text) 
        super(message_chat_id, text)
    end
end
