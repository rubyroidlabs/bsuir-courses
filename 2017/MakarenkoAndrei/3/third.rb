require 'rubygems'
require 'mechanize'
require 'json'
require 'telegram/bot'

class Base
attr_accessor :token, :names, :bool
  def initialize
      @token = '489259447:AAGg1LUjJ5DAIHuF9OXy20DbjYJbBTYgj5M'
      @names = Array.new()
  end
    
  def main
    agent = Mechanize.new
    page = agent.get('http://www.imdb.com/list/ls072706884/')
    page.css('.info b a').each do |item|
      @names << item.text
    end
  end
    
  def bot_main 
    Telegram::Bot::Client.run(@token) do |bot| 
      bot.listen do |message|
        @bool = false
        @names.each do |name|
          if name == message.text
            @bool = true
          end
        end
        if @bool
          bot.api.send_message(chat_id: message.chat.id, text: "Да")
        else
          bot.api.send_message(chat_id: message.chat.id, text: "Не найдено данныхсвьл")
        end
        case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
        when '/stop'
          bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
        end
      end
    end
  end
end

program = Base.new
program.main
program.bot_main
