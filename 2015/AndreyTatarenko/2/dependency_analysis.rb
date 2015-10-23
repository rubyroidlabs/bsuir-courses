require 'rubygems'
require 'colorize'

class DependencyAnalysis
  def initialize
    @pattern = /^(~>|>=|<)/
    @hash = {}
  end

  def parse(args)
    args.each do |arg|
      begin
        @parameter = arg.match(@pattern)[0]
      rescue
        abort('No correct parameter in arg'.red)
      end
      @version = arg[@parameter.length + 1..arg.length - 1]
      abort('Incorrect version'.red) unless Gem::Version.correct?(@version)
      @hash[@parameter] = @version
    end

    abort('Avoid duplicated dependence'.red) unless @hash.size == args.size

    @hash
  end
end
