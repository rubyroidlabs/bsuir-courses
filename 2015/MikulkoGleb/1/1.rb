require 'curses'

class Animator
  def initialize
    @frames = Array.new(3)
    @frames[0] = "                ___
       __      /   )
      (o )    /   )
 ==T===  \\__ /  _) ___
  ( )  \\    /  /     /
 (   )  \\___________/
(     )
(     )
 (___)"
    @frames[1] = "
       __
      (o )
 ==T===  \\____________
  ( )  \\    (_______)/
 (   )  \\___________/
(     )
(     )
 (___)"
    @frames[2] = "
       __
      (o )
 ==T===  \\____________
  ( )  \\             /
 (   )  \\___\\  \\_ __/
(     )      \\   )
(     )       \\   )
 (___)         \\___)"
  end

  def animate
    Curses.init_screen

    frame_width = @frames[0].split("\n").max_by(&:length).length
    frame_height = @frames[0].split("\n").length

    pos_cursor_x = Curses.cols - frame_width - 1
    pos_cursor_y = (Curses.lines - frame_height) / 2

    begin
      while pos_cursor_x > 0
        @frames.each do |frame|
          Curses.clear
          frame.split("\n").each do |str|
            Curses.setpos(pos_cursor_y, pos_cursor_x)
            Curses.addstr(str)
            pos_cursor_y += 1
            Curses.addstr("\n")
          end
          pos_cursor_y = (Curses.lines - frame_height) / 2
          Curses.refresh
          sleep(0.05)
          pos_cursor_x -= 1
        end
      end
    ensure
      Curses.close_screen
    end
  end
end

Animator.new.animate
