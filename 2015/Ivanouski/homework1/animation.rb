#!/usr/bin/env ruby

# @version 0.1.7
# @author S. Ivanouski

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
      sign1 = @sign * rand(5..@rand_max)    # generating line of signs
      sign0 = @spaces * rand(3..@rand_max0) # generating spacing
      puts sign0 + sign1
      sleep @sleeping
    end
  end
end

system 'clear'

ziga = Signs.new('*', ' ', 30, 98, 20, 0.05)

ziga.print_sign

sleep 1
system 'clear'

exit 0
