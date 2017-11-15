require 'telegram/bot'
require 'webrick'
require 'json'
require 'csv'
require 'pry'
require 'rubocop'
require_relative './data/constants.rb'
require_relative './lib/start.rb'
require_relative './lib/result.rb'
require_relative './lib/my_servlet.rb'
require_relative './lib/search.rb'

class Bot
  def initialize
    @token = TOKEN
  end

  def start
    list = Start.preprocess('data/source')
    Telegram::Bot::Client.run(@token) { |bot| @bot = bot }
    server = WEBrick::HTTPServer.new(Port: 3000)
    server.mount('/', MyServlet, @bot, list)
    trap('INT') { server.shutdown }
    server.start
  end
end

Bot.new.start
