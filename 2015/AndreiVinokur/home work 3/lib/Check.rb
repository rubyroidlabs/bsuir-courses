require 'optparse'

class Check
  attr_reader :group

  def initialize(arguments)
    @group = arguments
    if @group[0] == nil || @group == '-h'
      puts 'Template: ruby bsuir.rb <group_number>'
      exit
    end
    check = OptionParser.new do|opts|
      opts.banner = 'Template: ruby bsuir.rb <group_number>'
    end
    check.parse!
  end

  def size
    if @group.size > 6
      puts 'Incorrect number of group'
      puts 'Group number must be 6 numbers'
      exit
    end
  end

  def correct
    if @group =~ /\d+/
      puts 'Incorrect number of group'
      puts 'group number consists only of the numbers'
      exit
    end
  end

  def found(teachers)
    if teachers.empty?
      puts "No groups found\n\n"
      exit
    end
  end
end
