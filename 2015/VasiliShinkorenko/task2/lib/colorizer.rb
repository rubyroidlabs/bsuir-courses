require 'colorize'

class Colorizer
  def initialize(versions, filtered_versions)
    @versions = versions
    @filtered_versions = filtered_versions
  end

  def colorize
    if @filtered_versions.first > (@versions - @filtered_versions).last
      @filtered_versions.map { |v| puts v.red }
      puts @versions - @filtered_versions
    elsif @filtered_versions.first < (@versions - @filtered_versions).last
      puts @versions - @filtered_versions
      @filtered_versions.map { |v| puts v.red }
    else
      puts @versions
    end
    rescue NoMethodError
      print "It seems there is no such version of this gem.\n"
  end
end
