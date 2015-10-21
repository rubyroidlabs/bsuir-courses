require 'optparse'

# Parse user input.
class Parser
  attr_reader :gem_name, :filter

  def parse
    parser = OptionParser.new do |opts|
      opts.banner = 'USAGE: <gem name> <filters>'
    end

    parser.parse!

    @gem_name, *@filter = ARGV
    filter << '>= 0.0' if @filter.nil?
    fail 'Invalid input format.' if @gem_name.nil?
  end
end
