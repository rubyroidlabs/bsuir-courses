require 'telegram/bot'
require_relative 'TeleBotCommand'
# It shows info about the bot
class HelpCommand < TeleBotCommand
  def reply
    "Available commands list:
    /help - view help;
    /set_repo - set the repository to search;
    /show_repo - show current repository address;
    /search - search in the current repository, while searching type /1 to get the first page or /3 to get the third page, type /ok to end searching;
    /history - print your search queries.
    !Warning - search works only with the first 30 results! Sorry for this(((("
  end
end
