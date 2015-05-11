module Life
  class UI
    DELAY = 0.05

    def self.execute
      ui = new(load_board("glider.txt"))

      loop do
        ui.render()
        sleep(DELAY)
        ui.update()
      end
    rescue Interrupt
      return
    end

    def self.load_board(path)
      Life::Board.from_text(File.read(path))
    end

    def initialize(board)
      Curses.init_screen()
      Curses.curs_set(0)
      @window = Curses::Window.new(0, 0, 0, 0)

      @board = board
    end

    def render
      @window.clear()

      @board.each do |x, y, alive|
        @window.setpos(y, x)
        @window.addstr(alive ? "#" : " ")
      end

      @window.refresh()
    end

    def update
      @board.tick()
    end
  end
end
