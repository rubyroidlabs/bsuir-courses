class Check
  def initialize(arguments)
    unless arguments.size == 2
      puts 'Incorrect number of arguments'
      puts 'Template: ruby gemfiler <gem_name> [\'version conditions\']'
      exit
    end

    @name, @interval = arguments

    unless @name =~ /\w+/
      puts 'Incorrect name of gem'
      puts 'Template: ruby gemfiler <gem_name> [\'version conditions\']'
      exit
    end

    unless @interval =~ /(~>|>=|<=|<|>|<|<=|=|!=)\s(\d+\.)*\d+/
      puts 'Incorrect interval of versions of gem'
      puts 'Template: ruby gemfiler <gem_name> [\'version conditions\']'
      exit
    end
  end

  def get_name
    @name
  end

  def get_interval
    @interval
  end
end
