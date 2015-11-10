class ArgumentsParser
  attr_reader :group_number
  def initialize(arguments)
    @group_number = arguments
    if @group_number[0] == nil || @group_number.include?('-h')
      puts 'Usage: ./bsuir-reviews.rb [group_number]
            Examples: ruby bsuir-reviews.rb 421701 '
      exit
    end
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: ./bsuir-reviews.rb [group_number]
                     Examples: ruby bsuir-reviews.rb 421701"
    end
    parser.parse!
  end

  def check
    if @group_number.to_s.size != 10
      puts 'Group number is 6 numbers'
      exit 1
    end
    if @group_number =~ /\d{6}/
      puts 'Group number consists only of numbers'
      exit 1
    end
  end
end
