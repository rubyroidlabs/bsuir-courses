require_relative "helper"
require "./lib/bot_command/base"

Dir["./lib/bot_command/*.rb"].each { |file| require file }

# cointain all bot commands
module BotCommand
end
