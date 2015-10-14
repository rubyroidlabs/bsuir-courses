#!/usr/bin/env ruby

# Ping chart
# Required: Unix-like system, head, tail, awk.
# @version 0.2.9
# @author S.Ivanouski

class String
  # colorization
  def colorize(color_code) # 31..36 / 41..46
    "\e[#{color_code}m#{self}\e[0m"
  end
end

class Ping
  def initialize(site, iter, awk, sleeping, x, y, z)
    @site = site                  # Host to ping
    @iter = iter                  # Iterations
    @awk = awk                    # Column number in ping output
    @sleeping = sleeping          # Timer
    @x = x                        # Green zone
    @y = y                        # Yellow zone
    @z = z                        # Red zone
  end

  def wait_n_clear(a) # Lambda would be better, but i don't now what is Lambda.
    sleep @sleeping
    system 'clear'
    print @site.colorize(44) + ' '
    print a
  end

  def ping_line
    @iter.times do
      ping = `ping -c 1 #{@site} | head -2 | tail -1 | awk '{print $#{@awk}}'`
      a = ping.delete('time=').to_i
      case a
      when 1..@x  then
        linex = (' ' * a).colorize(42)
        wait_n_clear(a)
        print ' ' + linex
      when @x..@y then
        linex = (' ' * @x).colorize(42)
        liney = (' ' * (a - @x)).colorize(43)
        wait_n_clear(a)
        print ' ' + linex + liney
      when @y..@z then
        linex = (' ' * @x).colorize(42)
        liney = (' ' * (@y - @x)).colorize(43)
        linez = (' ' * (a - @y)).colorize(41)
        wait_n_clear(a)
        print ' ' + linex + liney + linez
      else
        line0 = (' ' * (@z + 5)).colorize(41)
        wait_n_clear(a)
        print ' ' + line0
      end
    end
  end
end

system 'clear'

vkcom = Ping.new('vk.com', 50, 8, 0.1, 40, 55, 80)
vkcom.ping_line

facebookcom = Ping.new('facebook.com', 50, 8, 0.1, 20, 40, 100)
facebookcom.ping_line

system 'clear'

exit 0
