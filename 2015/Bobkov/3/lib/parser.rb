class Parser
  attr_reader :number

  def initialize(arguments)
    parser = OptionParser.new do|opts|
      opts.banner = "Usage: ruby bsuir-reviews [number]
        Examples: ruby bsuir-reviews.rb 421702"
    end
    parser.parse!
    @number = arguments[0]
    unless arguments.size == 1 && @number =~ /\d{6}/
      puts "Usage: ruby bsuir-reviews [number]
      Examples: ruby bsuir-reviews.rb 421702"
      exit
    end
    if @number =~ /-h/
      puts "Usage: ruby bsuir-reviews [number]
      Examples: ruby bsuir-reviews.rb 421702"
      exit
    end
    @number
  end
end
