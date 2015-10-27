require 'colorize'

class Visualizer
  def initialize(versions_hash)
    @hash = versions_hash
  end

  def print
    @hash.each do |key, value|
      if value
        puts key.red
      else
        puts key
      end
    end
  end
end
