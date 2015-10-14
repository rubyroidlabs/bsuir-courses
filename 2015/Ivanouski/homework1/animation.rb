#!/usr/bin/env ruby

# @version 0.2.4
# @author S. Ivanouski

class String
  # colorization
  def colorize(color_code) # 31..36 / 41..46
    "\e[#{color_code}m#{self}\e[0m"
  end
end

class Signs
  def initialize(sign, spaces, max, sleeping)
    @sign = sign            # sign to draw
    @spaces = spaces        # spacing
    @max = max              # maximum spacers per line
    @sleeping = sleeping    # time between drawing lines (sec)
  end

  def print_sign
    l = ((`tput lines`).to_i - 1)
    h = ((`tput cols`).to_i - 5)
    l.times do
      spacing = @spaces * rand(5..@max)
      signing = @sign * rand(20..(h - @max))
      puts spacing + signing.colorize(rand(31..36))
      sleep @sleeping
    end
  end
end

system 'clear'

pic = Signs.new('*', ' ', 20, 0.05)
pic.print_sign

sleep 2
system 'clear'

exit 0
