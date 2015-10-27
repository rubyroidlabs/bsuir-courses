require 'colorize'

class Visualizer
  attr_reader :versions, :filtered_versions

  def initialize(versions, filtered_versions)
    @versions = versions
    @filtered_versions = filtered_versions
  end

  def visualize
    versions.each do |version|
      if filtered_versions.include?(version)
        puts version.colorize(:red)
      else
        puts version
      end
    end
  end
end
