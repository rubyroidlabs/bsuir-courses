#!/usr/bin/env ruby

# @version 0.2.1
# @author S. Ivanouski

class String
  # colorization
  def colorize(color_code) # 31..36 / 41..46
    "\e[#{color_code}m#{self}\e[0m"
  end
end

class Signs
  def initialize(sign, spaces, do_times, max, max0, sleeping)
    @sign = sign            # sign to draw
    @spaces = spaces        # spacing
    @do_times = do_times    # times to repeat drawing line
    @max = max              # maximum signs per line
    @max0 = max0            # maximum spacers per line
    @sleeping = sleeping    # time between drawing lines (sec)
  end

  def print_sign
    @do_times.times do
      spacing = @spaces * rand(5..@max0)
      signing = @sign * rand(20..@max)
      puts spacing + signing.colorize(rand(31..36))
      sleep @sleeping
    end
  end
end

system 'clear'

pic = Signs.new('*', ' ', 36, 130, 20, 0.05)
pic.print_sign

sleep 2
system 'clear'

exit 0
