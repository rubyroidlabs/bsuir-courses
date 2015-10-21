require_relative 'version_filter.rb'
require 'colored'
class VersionPuts
  extend VersionFilter
  def initialize(versions, option1, option2)
    @versions = versions
    @option1 = option1
    @option2 = option2
  end

  def print_filtered
    @versions.each do |version|
      if VersionPuts.filter(version, @option1, @option2)
        puts version.bold.red
      else
        puts version
      end
      end
  end
end
