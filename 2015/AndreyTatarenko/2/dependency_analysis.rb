# rubocop:disable Metrics/AbcSize

require 'rubygems'
require 'colorize'

class DependencyAnalysis
  def initialize(args)
    @pattern = /^(~>|>=|<)/
    @hash = {}
    args.each do |arg|
      begin
        @parameter = arg[@pattern,0]
        @version = arg[@parameter.length + 1..arg.length - 1]
        @hash.store(@parameter,@version)
      rescue
        abort('No correct parameter in arg'.red)
      end
    end
  end

  def parse
      @hash.each_value do |version|
        abort('Incorrect version'.red) unless Gem::Version.correct?(@version)
      end
    abort('Avoid duplicated dependence'.red) unless @hash.size == args.size
    @hash
  end
end
