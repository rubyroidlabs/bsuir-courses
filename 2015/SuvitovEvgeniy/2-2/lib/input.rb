require 'optparse'

class Parser
  def initialize
    @options = { a: false, e: false, r: false, z: false }
  end

  def parse
    OptionParser.new do |opts|
      opts.banner = 'Usage: grep [options]'
      opts.on('-A') do
        @options[:a] = true
      end

      opts.on('-e') do
        @options[:e] = true
      end

      opts.on('-R') do
        @options[:r] = true
      end

      opts.on('-z') do
        @options[:z] = true
      end
    end.parse!
    @options
  end
end
