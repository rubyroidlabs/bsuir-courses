require 'telegram/bot'
require 'webrick'
require 'json'
require 'redis'
require_relative 'servlet'

TOKEN = '289410618:AAGCYzweaG-rTtTR15mvamdJ_yFxACmJMLU'.freeze

# https://api.telegram.org/bot289410618:AAGCYzweaG-rTtTR15mvamdJ_yFxACmJMLU/setWebhook?url=https://b978b6b9.ngrok.io/webhooks/telegram_Xi39zZtru6V3oop897cz

# Class Bot
class Bot
  def initialize
    @token = TOKEN
  end

  def start
    Telegram::Bot::Client.run(@token) { |bot| @bot = bot }
    server = WEBrick::HTTPServer.new(Port: 8080)
    server.mount('/', MyServlet, @bot)
    trap('INT') { server.shutdown }
    server.start
  end
end
