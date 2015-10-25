require 'gems'
require 'optparse'

class Parser
  attr_accessor :processed_list
  def initialize
    @color = []
    if Gems.versions(ARGV[0]).class == String
      raise 'This rubygem could not be found.'
    end
    @gem_list = Gems.versions(ARGV[0]).map { |cur_gem| cur_gem['number'] }
    @gem_list = @gem_list.reverse.uniq
    @gem_list_size = @gem_list.size - 1
    @processed_list = []
  end
  
  def color_check(color, index)
    if @color[index] == nil
      @color[index] = color
    else
      @color[index].prepend(color)
    end
    @processed_list[index] = { 'version' => @gem_list[index], 'color' => @color[index] }
  end

  def searcher
    opt_parser = OptionParser.new do |opts|
      opts.on(/[<,>]/) do |current|
        0.upto(@gem_list_size) do |i|
          if @gem_list[i].scan(/[a-z]/).empty?
            if Gem::Dependency.new('', current).match?('', @gem_list[i])
              color_check('included', i)
            else
              color_check('excluded', i)
            end
          end
        end
      end
    end
    opt_parser.parse!
  end
end
