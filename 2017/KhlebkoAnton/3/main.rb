require_relative 'bot.rb'

bot = Bot.new(ENV['TOKEN'])
bot.work
