class Animation
  def initialize(picture, console_width = 80)
    @pict = picture
    @output = []
    @pict.size.times do
      @output.push('')
    end
    console_width.times do
      (0..3).each do |i|
        @output[i] += ' '
      end
    end
  end

  def paint(console_width = 80, pause = 0.05)
    tmp_pict = @pict
    (console_width + tmp_pict[0].length).times do
      (0..3).each do |i|
        @output[i].slice!(0)
        if tmp_pict[i].nil?
          tmp_pict[i] += ' '
        else

          tmp = tmp_pict[i].slice! 0
          if !tmp.nil?
            @output[i] += tmp
          end
        end

      end
      puts @output
      sleep pause
      system('clear')
    end
  end
end