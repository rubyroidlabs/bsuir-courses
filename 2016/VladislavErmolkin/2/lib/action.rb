require 'redis'
require 'webrick'

class Action
  attr_reader :user
  
  def initialize(user, text)
    @text = text.gsub("\n", "")
    @user = user
  end

  def text_validation
  end
end
