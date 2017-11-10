class Parser3
  def initialize(page)
    @page = page
    @data_info = []
    @data_actors = []
    @data = []
    @i = 0
  end

  def take_data
    count_actors = 15
    count_p = 41
    extra_symbols = 3

    while @i < count_actors
      actors = @page.css('.article-content h2 strong')[@i].text
      @data_actors << actors
      @i += 1
    end
    @i = 0
    while @i < count_p
      info = @page.css('.article-content > p')[@i].text
      @i += 1
      @data_info << info
    end
    @i = 0
    @data_info.delete_if(&:empty?)
    @data_info.shift(extra_symbols)
    @data_info[0] += @data_info[1]
    @data_info[3] += @data_info[4]
    @data_info[5] += @data_info[6]
    @data_info[7] += @data_info[8]
    @data_info[9] += @data_info[10]
    @data_info[18] += @data_info[19]
    @data_info[20] += @data_info[21]
    @data_info.delete_at(21)
    @data_info.delete_at(19)
    @data_info.delete_at(10)
    @data_info.delete_at(8)
    @data_info.delete_at(6)
    @data_info.delete_at(4)
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
