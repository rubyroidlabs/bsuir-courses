require_relative "action"
require_relative "answers"

# Class Start.
class Start < Action
  def initialize(name)
    super(nil, "")
    @name = ", " + name
  end

  def run
    "Hi#{@name}." + START_ANSWER
  end
end
