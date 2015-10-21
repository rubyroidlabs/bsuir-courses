# Class for filtered data output
class Filter
  def initialize(list, filter_options)
    @list = list
    @filter_method = lambda do |x|
      filter_options.count.times do |i|
        unless Gem::Dependency.new('', filter_options[i]).match?('', x)
          return false
        end
      end
      true
    end
  end

  def output
    @list.each do |element|
      if @filter_method.call(element)
        puts element.colorize(:green)
      else
        puts element
      end
    end
  end
end
