require 'colorize'

class Vizualizer

  def initialize(versions_filter, versions)
    @versions_filter, @versions = versions_filter, versions
  end

  def output
    if @versions_filter != nil
      @versions_filter.map {|s| puts s.red}
      puts @versions - @versions_filter
    else
      puts @versions
    end
  end

end