class Parameter
  def initialize(*arg)
    @address = arg[0][0]
    @parameter = []
    @gemVersion = []

    1.upto(arg[0].size - 1) do |element|
      if(['>=', '<=', '~>', '<', '>'].include? arg[0][element].split(' ')[0])
        @parameter.push(arg[0][element].split(' ')[0])
      else
        puts "Incorrectly parameters"
        exit
      end
    end

    1.upto(arg[0].size - 1) do |element|
      @gemVersion.push(arg[0][element].split(' ')[1])
    end
  end

  def getAddress()
    return "https://rubygems.org/gems/#{@address}/versions"
  end

  def getParameter()
    return @parameter
  end

  def getGemVersion()
    return @gemVersion
  end
end
