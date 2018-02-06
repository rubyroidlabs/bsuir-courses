require 'telegram/bot'
require_relative 'lib/parser'
require 'colorize'
require_relative 'lib/message_responder'

TOKEN = ENV['TOKEN']

class Bot
  def initialize
    @token = TOKEN
    @data = Parser.new.get_data
  end

  def run
    puts 'LGBTInspectorBot started'.green
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.listen do |message|
        options = { bot: bot, message: message, data: @data }
        MessageResponder.new(options).respond
      end
    end
  end
end

Bot.new.run
