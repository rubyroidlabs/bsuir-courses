# Recieves an options
class Reciever
  attr_accessor :gem_name, :option1, :option2

  def recieve(gem_name, option1, option2 = nil)
    @gem_name = gem_name
    @option1 = option1
    @option2 = option2
    puts "Your first option is: #{@option1}"
    puts "Your second option is: #{@option2}"
    puts "Required gem name is: #{@gem_name}"
  end
end
