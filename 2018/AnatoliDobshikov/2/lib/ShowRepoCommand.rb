# here we will show to User his current repository
require 'telegram/bot'
require_relative 'TeleBotCommand'
# command class
class ShowRepoCommand < TeleBotCommand
  def reply
    "Current repository is #{@user.current_repo}."
  end
end
