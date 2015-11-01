require 'colorize'

class Writer
  def self.write(text, color)
    puts text.colorize(color)
  end
end
