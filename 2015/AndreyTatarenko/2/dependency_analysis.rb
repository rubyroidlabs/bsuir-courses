require 'rubygems'
require 'colorize'

class DependencyAnalysis
  def initialize
    @pattern  = /^(~>|>=|<)/
    @hash = {}
  end

  def parse(args)
    args.each do |arg|
      @parameter = ''
      if !arg.match(@pattern).nil?
        @parameter = arg.match(@pattern)[0]
      else
        abort('No correct parameter in arg'.red)
      end
      @version = arg[@parameter.length+1..arg.length-1]
      abort('Incorrect version'.red) unless Gem::Version.correct?(@version)
      @hash[@parameter] = @version
    end

    unless @hash.size == args.size
      if @hash.has_key?('~>')
        abort('Only one pessimistic constraint can be!'.red)
      else
        abort('Duplicates in dependencies'.red)
      end
    end
    @hash
  end
end