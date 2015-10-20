class Parameter
  def initialize(*arg)
    @address = arg[0][0]
    @parameter = []
    @gem_version = []

    1.upto(arg[0].size - 1) do |element|
      if ['>=', '<=', '~>', '<', '>'].include? arg[0][element].split(' ')[0]
        @parameter.push(arg[0][element].split(' ')[0])
      else
        puts "Incorrectly parameters"
        exit
      end
    end

    1.upto(arg[0].size - 1) do |element|
      @gem_version.push(arg[0][element].split(' ')[1])
    end
  end

  def get_address
    return "https://rubygems.org/gems/#{@address}/versions"
  end

  def get_parameter
    return @parameter
  end

  def get_gem_version
    return @gem_version
  end
end
