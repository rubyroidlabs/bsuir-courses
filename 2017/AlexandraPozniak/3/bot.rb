require 'telegram/bot'
require_relative 'bin/web_scraper'
require_relative 'bin/message_responder'

token = '452454444:AAFm-BLS1L7zcRby1gQn7qtw6MabOhrkctU'
data_parser = Parser.new
array = data_parser.set_data
data_parser.file_print(array)
CONTENT = data_parser.file_read
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    options = { bot: bot, message: message, data: CONTENT }
    MessageResponder.new(options).respond
  end
end
