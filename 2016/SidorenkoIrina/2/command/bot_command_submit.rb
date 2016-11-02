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
        bot.api.send_message(chat_id: @message_chat_id, text: text, reply_markup: markup, parse_mode: 'Markdown')
    end

    def save_passed_lab(file_name,subject, lab)
    	ChatHistory.new(@message_chat_id, file_name).save_to_file(subject, lab)
    end

    def hide_keyboard
    	#mark = Telegram::Bot::Types::InlineKeyboardButton.new(hide_keyboard: true)
         p "kkkk"
        bot.api.send_message(chat_id: @message_chat_id, text: text, parse_mode: 'Markdown')
        p "lll"
    end
    	
    def submit   
	    info = read_file("subject")
		subject=[]
        a=[]
        labs=[]
        for i in 0..info.size-1 
            puts "#{i} : #{info[i][0]}"
            subject.push(info[i][0])
            labs.push(info[i][1])
        end
        for i in 0..subject.size-1 
            a.push(Telegram::Bot::Types::InlineKeyboardButton.new(text: subject[i], callback_data: subject[i]))
        end
        markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: a, one_time_keyboard: true)
        send(markup, "\xF0\x9F\x93\x9A Что сдавал?")
        l=[]
        bot.listen do |message|
        	if Telegram::Bot::Types::CallbackQuery
        		#hide_keyboard
        		for k in 0..subject.size-1
					if message.data == subject[k]
						puts "EEE"
						puts labs[k] 
						for x in 1..labs[k].to_i
            				l.push(Telegram::Bot::Types::InlineKeyboardButton.new(text: x, callback_data: x))
            			end
            			m = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: l, one_time_keyboard: true)
                        send(m, "Какую лабу?")
				    elsif message.data.to_i.between?(1,labs[k].to_i) 
				    	send_message("\xF0\x9F\x91\x8F Ты сдал/а #{message.data.to_i} лабу по #{subject[k]}. Красавчег!")
				    	save_passed_lab('submit', subject[k], message.data.to_i)
				    	break
				    end
				end
       		end
        end
	end

    def send_message(text) 
		super(message_chat_id, text)
	end
end