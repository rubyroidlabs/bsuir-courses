# Class for filtered data output
class Filter
  def initialize(list, filter_options)
    @list = list
    @filter_options = filter_options
  end

  def filter(str)
    @filter_options.count.times do |i|
      unless Gem::Dependency.new('', @filter_options[i]).match?('', str)
        return false
      end
    end
    true
  end

  def colorize_output
    @list.each do |str|
      if filter(str)
        puts str.colorize(:green)
      else
        puts str
      end
    end
  end
end
