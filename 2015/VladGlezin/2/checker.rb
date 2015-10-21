require 'gems'

Dir['./*.rb'].each { |file| require file }

class Checker

  def initialize(name, option1, option2 = nil)
    @name = name
    @option1 = Gem::Dependency.new(@name.to_s, option1)
    if option2
      @option2 = Gem::Dependency.new(@name.to_s, option2)
      @double = true
    else
      @double = false
    end
  end

  def fits?(ver)
    if @double
      @option1.match?(@name.to_s, ver) && @option2.match?(@name.to_s, ver)
    else
      @option1.match?(@name.to_s, ver)
    end
  end
end
