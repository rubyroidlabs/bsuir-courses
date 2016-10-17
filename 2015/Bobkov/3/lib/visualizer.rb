require 'colored'

class Visualiser
  def initialize(text, feedback)
    if feedback == 'positive'
      puts text.green
    elsif feedback == 'negative'
      puts text.red
    else
      puts text
    end
  end
end
