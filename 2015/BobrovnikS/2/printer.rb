# Handle and print gem data
class String
  def red
    colorize(self, "\e[1m\e[31m")
  end

  def colorize(text, color_code)
    "#{color_code}#{text}\e[0m"
  end
end

class Printer
  attr :cache_array, :gem_name, :option1, :option2

  def initialize(name, option1, option2 = nil)
    @cache_array ||= Array.new
    @gem_name = name
    @option1 = option1
    @option2 = option2
  end

  def print_result(array)
    @cache_array = array
    if option2
      cache_array.each do |key|
        if Gem::Dependency.new(@gem_name.to_s, @option1).match?(@gem_name.to_s, key) && Gem::Dependency.new(@gem_name.to_s, @option2).match?(@gem_name.to_s, key)
          puts key.red
        else
          puts key
        end
      end
    else
      cache_array.each do |key|
        if Gem::Dependency.new(@gem_name.to_s, @option1).match?(@gem_name.to_s, key)
          puts key.red
        else
          puts key
        end
      end
    end
  end
end
