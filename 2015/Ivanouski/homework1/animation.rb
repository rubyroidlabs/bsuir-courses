#!/usr/bin/env ruby

# @version 0.1.2
# @author S. Ivanouski

class Signs
  def initialize(sign, do_times, rand_max, sleeping)
    @sign = sign            # sign to draw
    @do_times = do_times    # times to repeat drawing line
    @rand_max = rand_max    # maximum signs in the line
    @sleeping = sleeping    # time between drawing lines (sec)
  end

  def print_sign
    @do_times.times do
      random_var = Random.new
      puts @sign*random_var.rand(5..@rand_max)
      sleep @sleeping
    end
  end
end

ziga = Signs.new('@', 30, 98, 0.04)

ziga.print_sign

system 'clear'

exit 0
