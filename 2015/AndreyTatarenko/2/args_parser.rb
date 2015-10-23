require 'colorize'
require './dependency_analysis.rb'

class ArgsParser
  def initialize(args)
    @quantity_of_args = 2..3
    if !@quantity_of_args.include?(args.size)
      abort('Incorrect quantity of arguments!'.red)
    else
      @gem_name = args.first
      args.delete_at(0)
      @gem_dependencies = DependencyAnalysis.new.parse(args)
    end
  end

  def gem_name
    @gem_name
  end

  def gem_dependencies
    @gem_dependencies
  end
end
