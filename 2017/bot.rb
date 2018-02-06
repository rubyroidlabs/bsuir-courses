require 'telegram_bot'
require_relative 'translit'
require_relative 'parser'
# bot class
class Bot
  attr_accessor :bot
  attr_accessor :command
  attr_accessor :token
  attr_accessor :database
  attr_accessor :parser
  attr_accessor :flag
  attr_accessor :translit
  def initialize
    @token = '405896754:AAHtzYzXcOb76_6QFuJSQqgg_aQFt4cIIJs'.freeze
    @bot = TelegramBot.new(token: @token)
    @parser = Parser.new
    @database = @parser.read_people_list
    @translit = TranslitSoft.new
  end

  def run_bot
    bot.get_updates(fail_silently: true) do |message|
      @command = message.get_command_for(bot)
      message.reply do |reply|
        @flag = false
        database_search(reply)
        reply.text = 'Нет' if @flag == false
        reply.send_with(bot)
      end
    end
  end

  def database_search(reply)
    @database.each do |elem|
      rus_command = Translit.convert(command)
      if elem == command || elem == rus_command
        set_answer('Да', reply)
        break
      elsif @translit.soft_comparison(elem, command) == true
        set_answer("Возможно Вы имели в виду #{elem}?", reply)
        break
      end
    end
  end

  def set_answer(str, reply)
    reply.text = str
    @flag = true
  end
end
