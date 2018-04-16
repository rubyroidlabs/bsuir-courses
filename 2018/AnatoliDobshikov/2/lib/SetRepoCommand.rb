require 'telegram/bot'
require_relative 'RepoCommandExtension'
require 'pg'
require 'active_record'
require_relative 'model/User.rb'
require 'octokit'
# set the repository to work with it
class SetRepoCommand < RepoCommandExtension
  def reply
    # if user is asked to set new adress of the repository
    if @user.last_command != '/set_repo'
      @user.update(last_command: '/set_repo')
      "Please, input repository address ('rubyroidlabs/bsuir-courses' for example):"
    # if user send his adress of the repository
    else
      # rescue errors
      error_message = initialize_repo(@message.text)
      unless @repo.nil?
        @user.update(current_repo: @message.text, last_command: 'none')
        return "#{@message.text} repository have set."
      else
        @user.update(last_command: 'none')
        return error_message
      end
    end
  end
end
