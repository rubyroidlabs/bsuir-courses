class Parser2
  def initialize(page)
    @page = page
    @data_info = []
    @data_actors = []
    @data = []
    @i = 0
  end

  def take_data
    count_actors = 15
    count_p = 34
    extra_symbols = 2

    while @i < count_actors
      actors = @page.css('.article-content h2 strong')[@i].text
      @i += 1
      @data_actors << actors
    end
    @i = 0
    while @i < count_p
      info = @page.css('.article-content > p')[@i].text
      @data_info << info
      @i += 1
    end
    @i = 0
    @data_info.delete_if(&:empty?)
    @data_info.shift(extra_symbols)
    @data_info[6] += @data_info[7]
    @data_info[9] += @data_info[10]
    @data_info.delete_at(7)
    @data_info.delete_at(9)

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
