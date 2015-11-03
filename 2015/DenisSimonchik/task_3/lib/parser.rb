require 'optparse'
class Parser
  attr_reader :num_of_group
  def initialize
    OptionParser.new do |opts|
      opts.banner = 'Usage: bsuir_reviews.rb <number of groupe>'
    end.parse!
    @num_of_group = ARGV[0]
  end
end
