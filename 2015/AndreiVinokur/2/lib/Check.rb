class Check
  attr_reader :name, :interval1, :interval2

  def initialize(arguments)
    check = OptionParser.new do|opts|
      opts.banner = 'Template: ruby gemfiler <gem_name> [\'version conditions\''
    end
    check.parse!

    unless arguments.size > 2 || arguments.size < 3
      puts 'Incorrect number of arguments'
      puts 'Template: ruby gemfiler <gem_name> [\'version conditions\']'
      exit
    end

    @name, @interval1, @interval2 = arguments

    unless @name =~ /\w+/
      puts 'Incorrect name of gem'
      puts 'Template: ruby gemfiler <gem_name> [\'version conditions\']'
      exit
    end

    unless @interval1 =~ /(~>|>=|<=|<|>|<|<=)\s(\d+\.)*\d+/ || 
    @interval2 =~ /(~>|>=|<=|<|>|<|<=|=|!=)\s(\d+\.)*\d+/
      puts 'Incorrect interval of versions of gem'
      puts 'Template of comparison operator: =; !=; >; <; >=; <=; ~>;'
      exit
    end
  end
end