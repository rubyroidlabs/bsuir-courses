require 'telegram/bot'
require_relative './lib/message_responder.rb'
require_relative './lib/redis_client.rb'

token = ENV['TELEGRAM_TOKEN']

redis = RedisClient.new
redis.refresh_data

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    options = { bot: bot, message: message, redis: redis }

    MessageResponder.new(options).respond
  end
end
