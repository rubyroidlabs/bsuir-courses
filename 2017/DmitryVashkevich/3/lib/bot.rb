require 'telegram/bot'
require_relative '../db/redis'
require_relative 'parser'
require_relative 'simple_fuzzy_match'
require_relative 'message_responder'
require_relative 'translate'

class Bot
  attr_reader :token, :coming_outs

  def initialize(token)
    @token = token
    @coming_outs = DataBase.new.get_data
  end

  def start
    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|
        message.text = Translate.new.translate(message.text)
        create_answer(bot, message)
      end
    end
  end

  private

  def create_answer(bot, message)
    coming_outs.each do |name, text|
      options = { bot: bot, message: message, name: name, text: text }
      next if MessageResponder.new(options).get_answer.nil?
      return nil
    end
    text = "#{message.text} не совершал каминг-аута"
    bot.api.send_message(chat_id: message.chat.id, text: text)
  end
end
