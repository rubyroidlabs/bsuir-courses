# This class is root class of actions.
class Action
  attr_reader :user

  def initialize(user, text)
    @text = text.delete "\n"
    @user = user
  end
end
