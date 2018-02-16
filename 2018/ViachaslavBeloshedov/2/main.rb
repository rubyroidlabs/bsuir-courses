require 'telegram/bot'
require 'pry'
require 'github_api'
require 'active_record'
require_relative 'models/connection.rb'
require_relative 'models/message.rb'
require_relative 'models/user.rb'
require_relative 'lib/receive_message.rb'
require_relative 'lib/send_message.rb'
require_relative 'lib/procces_message.rb'

class Bot
  @@token = ''
  def initialize
    @github = Github.new basic_auth: 'login:password', auto_pagination: true, per_page: 100
    Telegram::Bot::Client.run(@@token) do |bot|
      loop do
        information = self.listen(bot)
        self.handle(information)
      end
    end
  end

  def listen(bot)
    bot.listen do |message|
      return  information = {bot: bot, message: message}
    end
  end

  def handle(information)
    ReceiveMessage.new.read_message(information, self, @github)
  end
end

gitik = Bot.new
