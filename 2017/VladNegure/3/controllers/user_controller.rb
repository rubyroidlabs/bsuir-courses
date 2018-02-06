require_relative '../models/user'

class UserController
  attr_reader :users

  def initialize
    @users = {}
  end

  def add(id, name)
    @users[id] = User.new(id, name)
  end

  def delete(id)
    return false unless exist? id
    @users.delete(id)
  end

  def exist?(id)
    !@users[id].nil?
  end
end
