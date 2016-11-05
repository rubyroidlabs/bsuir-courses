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
        ChatHistory.new(@message_chat_id, file_name).read_from_file
    end
    	
    def send(markup, text)
        bot.api.send_message(chat_id: @message_chat_id, text: text, reply_markup: markup)
    end

    def save_passed_lab(file_name,subject, lab)
        ChatHistory.new(@message_chat_id, file_name).save_to_file(subject, lab)
    end

    def submit   
	info = read_file("subject")
	subject=[]
        a=[]
        labs=[]
        for i in 0..info.size-1 
            subject.push(info[i][0])
            labs.push(info[i][1])
        end
        for i in 0..subject.size-1 
            a.push(Telegram::Bot::Types::InlineKeyboardButton.new(text: subject[i], callback_data: subject[i]))
        end
        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: a)
        send(markup, "Что сдавал(а)?")
        count = 0
        bot.listen do |message|
	    if message.class == Telegram::Bot::Types::CallbackQuery
	       for k in 0..subject.size-1
		   if message.data == subject[k]
		      for x in 1..labs[k].to_i
			  l.push(Telegram::Bot::Types::InlineKeyboardButton.new(text: x, callback_data: x))
		      end
		      m = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: l)
		      send(m, "Какую лабу?")
		   elsif message.data.to_i.between?(1,labs[k].to_i) 
			 send_message("\xF0\x9F\x91\x8F Ты сдал(а) #{message.data.to_i} лабу по #{subject[k]}. Красавчег!")
			 save_passed_lab('submit', subject[k], message.data.to_i)
		         return 
		   end
		end
	    end
        end
    end

    def send_message(text) 
        super(message_chat_id, text)
    end
end
