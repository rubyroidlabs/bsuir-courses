require 'colorize'

# Implements methods for output.
class Writer
  attr_reader :versions, :filtered_versions

  def initialize(versions, filtered_versions)
    @versions = versions
    @filtered_versions = filtered_versions
  end

  def write_to_console
    @versions.each do |version|
      if @filtered_versions.include? version
        puts version.red
      else
        puts version
      end
    end
  end
end
