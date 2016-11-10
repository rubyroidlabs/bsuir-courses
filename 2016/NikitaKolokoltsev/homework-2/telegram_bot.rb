# Bot Server
class BotServer
  def bot
    token = "288795431:AAEmmmRKg0W5tEP9qGvO_DTJtF69OIP-lvc"
    Telegram::Bot::Client.run(token) { |bot| yield(bot) if block_given? }
  end

  def DATABASE
    DATABASE
  end
end

require "telegram/bot"
require_relative "lib/mp_telegram_bot"
require "webrick"
require "redis"
require "time_diff"
require_relative "lib/server"
require_relative "lib/friendly_date"
require_relative "lib/exceptions"
require_relative "lib/modified_hash"
require_relative "lib/bot"
require_relative "lib/bot_command"
require_relative "lib/bot_command_start"
require_relative "lib/bot_command_semester"
require_relative "lib/bot_command_subject"
require_relative "lib/bot_command_status"
require_relative "lib/bot_command_submit"
require_relative "lib/bot_command_reset"
require_relative "lib/bot_command_handler"

DATABASE = Redis.new

server = WEBrick::HTTPServer.new(Port: 8000)

server.mount "/", Server

trap("TERM") { server.shutdown }

server.start
