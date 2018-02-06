class Parser4
  def initialize(page)
    @page = page
    @data_info = []
    @data_actors = []
    @data = []
    @i = 1
  end

  def take_data
    count_actors = 10
    count_h2 = 12
    count_p = 25
    extra_symbols = 3

    while @i < count_h2
      actors = @page.css('.entry-content strong')[@i].text
      actors = actors.split('').drop(extra_symbols).join('') if @i > 1
      @data_actors << actors
      @i += 1
    end
    @data_actors.delete_at(6)
    @i = 1
    while @i < count_p
      info = @page.css('.entry-content p')[@i].text
      @i += 1
      @data_info << info
    end

    @i = 0
    @data_info[2] += @data_info[3]
    @data_info[5] += @data_info[6]
    @data_info[16] = @data_info[16] + @data_info[17] + @data_info[18]
    @data_info.delete_at(23)
    @data_info.delete_at(21)
    @data_info.delete_at(19)
    @data_info.delete_at(18)
    @data_info.delete_at(17)
    @data_info.delete_at(15)
    @data_info.delete_at(13)
    @data_info.delete_at(11)
    @data_info.delete_at(9)
    @data_info.delete_at(7)
    @data_info.delete_at(6)
    @data_info.delete_at(4)
    @data_info.delete_at(3)
    @data_info.delete_at(1)

    while @i < count_actors
      @data << {
        actors: @data_actors[@i],
        info: @data_info[@i]
      }
      @i += 1
    end
    @data
  end
end
