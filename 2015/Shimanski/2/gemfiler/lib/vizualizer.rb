# выводит красным помеченные версии
require 'colorize'

class  Vizualizer
  def initialize(versions)
    @versions = versions
  end

  def visualize
    @versions.map do |key, value|
      if value == true
        puts key.red
      else
        puts key
      end
    end
  end
end
