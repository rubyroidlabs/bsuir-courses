#!/usr/bin/env ruby

# Ping chart
# Required: Unix-like system, head, tail, awk.
# @version 0.2.6
# @author S.Ivanouski

class String
  # colorization
  def colorize(color_code) # 31..36 / 41..46
    "\e[#{color_code}m#{self}\e[0m"
  end
end

class Ping
  def initialize(site, iter, x, y, z, sleeping, awk)
    @site = site                # Host to ping
    @iter = iter                # Iterations
    @x = x                      # Green zone
    @y = y                      # Yellow zone
    @z = z                      # Red zone
    @sleeping = sleeping        # Timer
    @awk = awk                  # Column number in ping output
  end

  def wait_n_clear(a)
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
        line0 = (' ' * (@z + 2)).colorize(41)
        wait_n_clear(a)
        print ' ' + line0
      end
    end
  end
end

system 'clear'

googlecom = Ping.new('google.com', 33, 20, 40, 100, 0.1, 7)
googlecom.ping_line

googleby = Ping.new('google.by', 33, 10, 15, 40, 0.1, 7)
googleby.ping_line

vkcom = Ping.new('vk.com', 33, 40, 55, 80, 0.1, 8)
vkcom.ping_line

system 'clear'

exit 0
