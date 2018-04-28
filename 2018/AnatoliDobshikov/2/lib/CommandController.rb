# here is the main logic
# here we decide what to response
require 'telegram/bot'
require 'pg'
require 'active_record'
require_relative 'model/User.rb'

class CommandController
  # switch message and find exact answer
  def self.handler(message = Telegram::Bot::Types::Message.new)
    # trying to find a user in database
    user = User.find_by(id: message.from.id)
    # add user to database if he is not already in it
    if user.nil?
      user = User.create(id: message.from.id, current_repo: 'none', last_command: 'none')
    end
    # use the bot's memory to make complicated requests
    text = user.last_command == 'none' ? message.text : user.last_command
    # chose the suitable answer to the /question
    case text
    # first contact with the user)))
    when '/start'
      StartCommand.new(message)
    # show help
    when '/help'
      HelpCommand.new(message)
    # set new repo adress
    when '/set_repo'
      SetRepoCommand.new(message, user)
    # show user's new repository
    when '/show_repo'
      ShowRepoCommand.new(message, user)
    # search in commits
    when '/search'
      SearchCommand.new(message, user)
    # view search history
    when '/history'
      HistoryCommand.new(message)
    # default answer for unknown commands
    else
      TeleBotCommand.new()
    end
  end
end
