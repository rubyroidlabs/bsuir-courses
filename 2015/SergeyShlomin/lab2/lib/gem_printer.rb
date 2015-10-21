#Printer
require 'colorize'
class Gem_printer
  def initialize(versions, select_versions)
    @versions = versions
    @select_versions = select_versions
  end
  def print
    if !( @versions == nil )
      @versions.each do |version|
        if @select_versions.include? version
          puts version.red 
        else
          puts version
        end
      end
    end
  end
end
