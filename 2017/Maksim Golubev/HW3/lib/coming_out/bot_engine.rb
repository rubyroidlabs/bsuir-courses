require 'mechanize'
require 'json'
require 'uri'
require 'pry'
require 'redis'
require 'russian'
require 'telegram/bot'

class Bot
  TOKEN = '476714692:AAH_pCfRlJ_JPwq6O2HtOVpU1uHM1d4igfM'.freeze
  HI_ONE = 'I know all about coming-out. My darling '.freeze
  HI_TWO = ". Let's talk about it. Tell me sweety name💋".freeze

  def initialize
    @rus_mane = ''
    @redis = Redis.new
  end

  def bot_start
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.listen do |message|
        text = case message.text
               when '/start'
                 "#{HI_ONE}#{message.from.first_name.capitalize}#{HI_TWO}"
               when 'y'
                 if @redis.get(@rus_mane)
                   gay_info = JSON.parse @redis.get(@rus_mane)
                   "#{@rus_mane} \n #{gay_info.join("\n")}"
                 end
               else
                 if @redis.get(message.text)
                   gay_info = JSON.parse @redis.get(message.text)
                   "#{message.text} \n #{gay_info.join("\n")}"
                 elsif check_name(message)
                   @rus_mane = check_name(message)
                   "Did you mean #{check_name(message)}"
                 else
                   '110010100:Not found'
                 end
               end
        bot.api.send_message(chat_id: message.chat.id, text: text)
      end
    end
  end

  def check_name(msg)
    @redis.get(Russian.translit(msg.text.split.last))
  end
end
