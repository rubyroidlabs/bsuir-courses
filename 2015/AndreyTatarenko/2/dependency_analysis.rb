# rubocop:disable Metrics/AbcSize

require 'rubygems'
require 'colorize'

class DependencyAnalysis
  def initialize(args)

    @pattern = /^(~>|>=|<)/
    @parameters = []
    @versions = []
    @args_quantity = args.size
    args.each do |arg|
      begin
        @parameters << arg[@pattern,0]
        @versions << arg[@parameters.last.length + 1..arg.length - 1]
      rescue
        abort('No correct parameter in arg'.red)
      end
    end

  end

  def get_dependencies
    depends = parse_result
    if depends.size == @args_quantity
      depends
    else
      abort('Avoid duplicated dependence'.red)
    end
    depends
  end

  def parse_result
    depends = {}
    @args_quantity.times do |i|
      if Gem::Version.correct?(@versions[i])
        depends.store(@parameters[i],@versions[i])
      else
        abort('Incorrect version'.red)
      end
    end
    depends
  end
end
