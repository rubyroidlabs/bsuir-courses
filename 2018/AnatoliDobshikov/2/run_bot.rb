require 'telegram/bot'
require 'require_all'
require 'pg'
require 'active_record'
require 'yaml'
require_all 'lib'
# load passport with secret and personal information
PASSPORT = YAML.load(File.read('passport.yml'))
# ORM setup
ActiveRecord::Base::establish_connection(
  adapter: 'postgresql',
  host: '',
  user: PASSPORT['user'],
  database: PASSPORT['database']
)
# log all database actions
ActiveRecord::Base.logger = Logger.new(STDOUT)
# bot token setup
TOKEN = PASSPORT['bot_token']
# run bot
Telegram::Bot::Client.run(TOKEN, logger: Logger.new($stderr)) do |bot|
  # run messages listener
  bot.listen do |message|
    # set the request handler
    command = CommandController.handler(message)
    # sending the answer to the request
    begin
      bot.api.send_message(chat_id: message.chat.id, text: command.reply)
    rescue Telegram::Bot::Exceptions::ResponseError
      bot.api.send_message(chat_id: message.chat.id, text: "Something goes wrong. It is very strange. Maybe it will work later. Maybe not.\nError 400: Response Error.")
    end
  end
end
