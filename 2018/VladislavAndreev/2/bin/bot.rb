# frozen_string_literal: true

require 'telegram/bot'

require_relative '../lib/responds/replies_parser'
require_relative '../lib/db/database_connection'

token = ENV['TGKEY']

DataBase.establish_connection

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    Thread.start(message) do |message|
      options = { bot: bot, message: message }

      RepliesParser.new(options).parse
    end
  end
end
