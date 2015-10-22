# Overrided String class
class String
  def red
    colorize(self, "\e[1m\e[31m")
  end

  def colorize(text, color_code)
    "#{color_code}#{text}\e[0m"
  end
end

# Print gem data
class Printer
  attr_accessor :cache_array, :gem_name, :option1, :option2

  def initialize(name, option1, option2 = nil)
    @cache_array ||= []
    @gem_name = name
    @option1 = option1
    @option2 = option2
  end

  def print_result(array)
    handler = Handler.new(array, @gem_name, @option1, @option2)
    if option2
      handler.print_cond_2
    else
      handler.print_cond_1
    end
  end
end
