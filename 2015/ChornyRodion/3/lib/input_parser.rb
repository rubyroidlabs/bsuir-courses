# encoding: utf-8
# class for parsing input parameters
class InputParser
  def initialize(stream)
    @stream = stream
    @group_id = 0
  end

  def parse
    options = {}
    @stream.options do |opts|
      opts.banner = 'Usage: [group id]'
      opts.on('-h') { options[:h] = true }
      opts.parse!
    end
    if options[:h] || @stream.eql?(0)
      puts "Usage: ruby bsuir-reviews.rb [group id] \n"
      exit
    end
    @group_id = @stream[0].to_i
    if @group_id.nil?
      puts 'Invalid group id'
      exit
    end
  end

  attr_reader :group_id
end
