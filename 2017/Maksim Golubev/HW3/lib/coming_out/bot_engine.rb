require 'mechanize'
require 'json'
require 'uri'
require 'pry'
require 'redis'
require 'russian'
require 'telegram/bot'



class Bot_engine

TOKEN = '476714692:AAH_pCfRlJ_JPwq6O2HtOVpU1uHM1d4igfM'.freeze

  def initialize
    @incorrect_name = ""
    @redis = Redis.new
  end 

def bot_start

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "I know all about coming-out. My darling #{message.from.first_name.capitalize}. Let's talk about it. Tell me sweety name💋"
      )
    when 'y'
    text = if @redis.get(@incorrect_name)
               gay_info = JSON.parse @redis.get(@incorrect_name)
               "#{@incorrect_name} \n #{gay_info.join("\n")}"

           end
bot.api.send_message(
        chat_id: message.chat.id,
        text:text)
   
    else
      text = if @redis.get(message.text)
               gay_info = JSON.parse @redis.get(message.text)
               "#{message.text} \n #{gay_info.join("\n")}"
             else
               if @redis.get(Russian.translit message.text.split.last)
		  @incorrect_name = @redis.get(Russian.translit message.text.split.last)
                 "Did you mean #{@redis.get(Russian.translit message.text.split.last)}"
                 

               else
                 '110010100:Not found'
               end
             end
      bot.api.send_message(
        chat_id: message.chat.id,
        text: text
      )
    end

  end
end
end
end


