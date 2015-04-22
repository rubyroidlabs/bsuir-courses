class Gun
  def initialize
    @guns = File.open('shoot.txt').read.split("\n")
    @wall = File.open('wall.txt').read.split("\n")
    @boom_1 = File.open('boom_stage_1.txt').read.split("\n")
    @boom_2 = File.open('boom_stage_2.txt').read.split("\n")
    @boom_3 = File.open('boom_stage_3.txt').read.split("\n")
  end

  def process
    gun_writer
    add_wick
    add_core_stage_one
    wall_writer
    add_core_stage_two
    cut_scene_writer
  end

  private

  def clean_screen
    puts "\e[H\e[2J"
  end

  def gun_writer
    clean_screen
    puts @guns
  end

  def wall_writer
    clean_screen
    puts @wall
  end

  def cut_scene_writer
    clean_screen
    cut_scene
  end

  def cut_scene
    puts @boom_1
    wait(0.5)
    clean_screen
    puts @boom_2
    wait(0.5)
    clean_screen
    puts @boom_3
    wait(1)
  end

  def wick(x, y)
    @guns[x - 1][y]  = ' '
    @guns[x][y]  = '@'
    gun_writer
  end

  def add_wick
    (1..3).to_a.each do |elem|
      wait(0.5)
      wick(elem, 26)
    end
  end

  def wait(x)
    sleep(x)
  end

  def core_stage_one(x, y1 ,y2 , symbol)
    @guns[x][y1..y2] = symbol*6
    @guns[x + 1][y1 - 2..y2 + 2] = symbol*10
    @guns[x + 2][y1 - 3..y2 + 3] = symbol*12
    @guns[x + 3][y1 - 2..y2 + 2] = symbol*10
    @guns[x + 4][y1..y2] = symbol*6
    gun_writer
  end

  def add_core_stage_one
    (60..110).to_a.each do |elem|
      core_stage_one(4, elem, elem+5, 'Z')
      wait(0.01)
      core_stage_one(4, elem, elem+5, '-')
    end
  end

  def core_stage_two(x, y1 ,y2 , symbol)
    @wall[x][y1..y2] = symbol*6
    @wall[x + 1][y1 - 2..y2 + 2] = symbol*10
    @wall[x + 2][y1 - 3..y2 + 3] = symbol*12
    @wall[x + 3][y1 - 2..y2 + 2] = symbol*10
    @wall[x + 4][y1..y2] = symbol*6
    wall_writer
  end

  def add_core_stage_two
    (5..52).to_a.each do |elem|
      core_stage_two(4, elem, elem+5, 'Z')
      wait(0.01)
      core_stage_two(4, elem, elem+5, ' ')
    end
  end

end
loop do
gun = Gun.new
gun.process
end
