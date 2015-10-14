#!/usr/bin/env ruby
#v. 2

class Rocket

  def initialize(a, b, i, str) #Initializing variables
    @a, @b, @i, @str = a, b, i, str
  end

  def rocket(a, b) #Making a rocket
    $c = a * 3 + '>' + b * 5 + '=>'
  end

  def boom #Variables for ending explosion
    $a1 = "#{'o' * 10}\n"
    $a2 = "#{'o' * 2}" + '-BOOM-' + "#{'o' * 2}\n"
  end

  def animate(i, str) #Animate rocket
    loop do 
      system 'clear'
      str += ' '
      puts str + $c
      sleep 0.05
      i += 1
        if i == 60
        system 'clear'
        exp = $a1 + str + $a2 + str + $a1
        puts str + exp
        break loop
      end
    end
  end
end

rocket = Rocket.new('|', '-', 0, ' ') 
boom = Rocket.new('|', '-', 0, ' ')
animate = Rocket.new('|', '-', 0, ' ')
rocket.rocket('|', '-') #Calling methods from Rocket
boom.boom
animate.animate(0, ' ')
