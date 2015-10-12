#!/usr/bin/env ruby

# @version 0.2.0
# @author S. Ivanouski

class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end
end

class Signs
  def initialize(sign, spaces, do_times, rand_max, rand_max0, sleeping)
    @sign = sign            # sign to draw
    @spaces = spaces        # spacing
    @do_times = do_times    # times to repeat drawing line
    @rand_max = rand_max    # maximum signs per line
    @rand_max0 = rand_max0  # maximum spacers per line
    @sleeping = sleeping    # time between drawing lines (sec)
  end

  def print_sign
    @do_times.times do
      puts (@spaces * rand(3..@rand_max0)) + (@sign * rand(20..@rand_max)).colorize(rand(31..36))
      sleep @sleeping
    end
  end
end

system 'clear'

pic = Signs.new('*', ' ', 30, 98, 20, 0.05)
pic.print_sign

sleep 1
system 'clear'

exit 0
