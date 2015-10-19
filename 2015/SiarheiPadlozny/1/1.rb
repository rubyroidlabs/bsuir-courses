require 'curses'
include Curses

init_screen
curs_set(frame = 0)

ASCIICopter = []
File.open('copter.txt').each { |line| ASCIICopter.push(line[0..-2]) }

while frame += 1
  ASCIICopter.each_with_index do |line, index|
    if frame.even? && index == 0
      line.tr! '____', '++++'
      line.tr! '.', '-'
    else
      line.tr! '++++', '____'
      line.tr! '-', '.'
    end

    copter = (line + (' ' * (cols - 31))).chars.to_a
    frame.times { copter.unshift(copter.pop) }

    setpos(5 + index, 0)
    addstr copter.join
  end

  refresh
  sleep 0.05
end
