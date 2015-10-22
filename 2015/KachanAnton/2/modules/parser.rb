require 'optparse'
class Parser
  attr_reader :req_gem, :filter_version
  def parse
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: ./gemfiler.rb [gem_name] [conditions]
      Examples: ./gemfiler devise '~> 2.1.3'
                ./gemfiler rails '>= 3.1' '< 4.0'"
      opts.on("-h", "--help", "Output help") do
        puts opts
        exit
      end
    end
    parser.parse!
    @req_gem, @filter_version = ARGV
  end
end
