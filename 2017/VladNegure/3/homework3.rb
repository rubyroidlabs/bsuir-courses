require_relative 'controllers/application_controller'
Dir['libs/*.rb'].each { |file| require File.expand_path(file) }

bot = ApplicationController.new('your token here')
bot.run
