class Parser
  attr_reader :name, :specifier, :specifier2, :bl

  def initialize(arguments)
    parser = OptionParser.new do|opts|
      opts.banner = "Usage: ruby gemfiler [gem_name] [gem_versions]
        Examples: ruby gemfiler devise '~> 2.1.3'
                  ruby gemfiler rails '>= 3.1'
                  ruby gemfiler rails '>= 3.1' '< 4.0'"
    end
    parser.parse!

    @bl = false
    if arguments.size < 2 && arguments.size > 3
      raise ArgumentError
    end
    @name, @specifier, @specifier2 = arguments
    unless @name =~ /\w+/ && @specifier =~ /(~>|>=|<=|<|>)\s(\d+\.)*\d+/
      raise ArgumentError
    end
    if @specifier2 =~ /(<|<=)\s(\d+\.)*\d+/
      @bl = true
    else
      if @specifier2 =~ /^.*/
        raise ArgumentError
      end
    end
  end
end
