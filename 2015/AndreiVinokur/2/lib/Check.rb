class Check
  attr_reader :name, :interval1, :interval2

  def initialize(arguments)
    @name, @interval1, @interval2 = arguments

    check = OptionParser.new do|opts|
      opts.banner = 'Template: ruby gemfiler <gem_name> [\'version conditions\''
    end
    check.parse!

    unless arguments.size > 2 || arguments.size < 3
      puts 'Incorrect number of arguments'
      puts 'Template: ruby gemfiler <gem_name> [\'version conditions\']'
      exit
    end

    unless @name =~ /\w+/
      puts 'Incorrect name of gem'
      puts 'Template: ruby gemfiler <gem_name> [\'version conditions\']'
      exit
    end
  end
end
