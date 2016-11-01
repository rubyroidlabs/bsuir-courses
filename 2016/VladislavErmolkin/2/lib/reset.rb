require_relative 'action'
require_relative 'user'

class Reset < Action
  def run
    @user.reset
    @user.save
    'Clean sheet.'
  end
end