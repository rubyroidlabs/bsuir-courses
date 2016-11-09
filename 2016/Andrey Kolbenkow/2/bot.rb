require 'telegram/bot'
require 'yaml'
require_relative 'lib/console.rb'
require_relative 'lib/user.rb'
require_relative 'lib/message_handler'

class Bot
  def initialize
    @console = Console.new
    @message_handler = MessageHandler.new
    @user = User.new
    @token = YAML.load_file('token.yml')['TOKEN']
    @markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: KEYBOARD)
  end

  def run
    @console.start
    Telegram::Bot::Client.run(@token, logger: Logger.new(STDOUT)) do |bot|
      bot.listen do |message|
        @message_handler.decide_what_to_do_with_this_shit(message, @user)
      end
    end
  end
end

bot = Bot.new
bot.run
