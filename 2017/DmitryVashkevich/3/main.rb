require_relative 'lib/bot'

TOKEN = ENV['TELEGRAM_TOKEN']

bot = Bot.new(TOKEN)
bot.start
