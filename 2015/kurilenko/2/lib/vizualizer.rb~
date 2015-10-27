require 'colorize'

class Vizualizer
 def initialize(versions_filter, versions)
    @versions_filter = versions_filter 
    @versions = versions
  end
 
  def output
    if !expression.nil?
      @versions_filter.map { |s| puts s.red }
      puts @versions - @versions_filter
    else
      puts @versions
    end
  end
end

