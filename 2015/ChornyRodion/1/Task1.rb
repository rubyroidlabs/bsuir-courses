class Task001
  def initialize
    @message  = File.open('Text', 'r').read
    @lisa = ['', '', '']
    File.open('MonaLisa', 'r') do |f|
      f.read(407, @lisa[0])
      f.read(406, @lisa[1])
      f.read(406, @lisa[2])
    end
  end

  def show(seconds)
    i = 0
    j = 0
    (seconds * 10).times do
      puts @lisa[j % 3]
      puts @message[0..i]
      sleep(0.1)
      system 'clear'
      i += 1
      j += 1
    end
  end
end

sl_killer = Task001.new
sl_killer.show(10)
