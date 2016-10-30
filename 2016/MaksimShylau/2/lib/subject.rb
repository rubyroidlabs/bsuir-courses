# It can send messages
class Subject < Command
  def initialize(bot, message, name)
    super(bot, message)
    @name = name
    @labs_count = nil
    @done = 0
    @to_do = 0
  end
  attr_accessor :name
  attr_accessor :labs_count
  attr_accessor :done
  attr_accessor :to_do
end
