require 'colorize'

class Visualizer
  def initialize(versions_hash)
    @hash = versions_hash
  end

  def print
    @hash.each do |key, value|
      if value == false
        puts key
      else
        puts key.red
      end
    end
  end
end
