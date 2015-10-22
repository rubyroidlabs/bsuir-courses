class Parser
  def initialize(arguments)
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

  def getName
    @name
  end

  def getSp1
    @specifier
  end

  def getSp2
    @specifier2
  end

  def getBl
    @bl
  end
end
