#!/usr/bin/env ruby

# Ping chart
# @version 0.2.0
# @author S.Ivanouski

class String
  # colorization
  def colorize(color_code) # 31..36 / 41..46
    "\e[#{color_code}m#{self}\e[0m"
  end
end

class Ping_chart
  def initialize(site, iterations, x, y, z, sleeping)
    @site = site
    @iter = iterations
    @x = x
    @y = y
    @z = z
    @sleeping = sleeping
  end

  def ping_line
    def wait_n_clear(a)
      sleep @sleeping
      system 'clear'
      print @site.colorize(44) + ' '
      print a
    end

    @iter.times do
      ping = `ping -c 1 #{@site} | head -2 | tail -1 | awk '{print $7}'`
      a = ping.delete('time=').to_i
      case a
      when 1..@x  then
        linex = (' ' * a).colorize(42)
        wait_n_clear(a)
        print ' ' + linex
      when @x..@y then
        linex = (' ' * @x).colorize(42)
        liney = (' ' * (a-@x)).colorize(43)
        wait_n_clear(a)
        print ' ' + linex + liney
      when @y..@z then
        linex = (' ' * @x).colorize(42)
        liney = (' ' * (@y-@x)).colorize(43)
        linez = (' ' * (a-@y)).colorize(41)
        wait_n_clear(a)
        print ' ' + linex + liney + linez
      when @z..Float::INFINITY then
        line0 = (' ' * (@z + 2)).colorize(41)
        wait_n_clear(a)
        print ' ' + line0
      end
    end
  end
end

system 'clear'

googlecom = Ping_chart.new('google.com', 50, 20, 40, 100, 0.1)
googleby = Ping_chart.new('google.by', 50, 10, 15, 50, 0.1)
googlecom.ping_line
googleby.ping_line

system 'clear'

exit 0
