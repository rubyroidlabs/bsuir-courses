require_relative "action"
require_relative "answers"

# Class Start.
class Start < Action
  def run
    "Hi#{@text}." + START_ANSWER
  end
end
