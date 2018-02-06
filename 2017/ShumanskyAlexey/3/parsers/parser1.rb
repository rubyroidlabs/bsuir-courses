class Parser1
  def initialize(page)
    @page = page
    @data = []
    @i = 0
  end

  def take_data
    count_actors = 15
    extra_symbols = 3

    while @i < count_actors
      actors = @page.css('.theiaPostSlider_preloadedSlide h2 strong')[@i].text
      actors = actors.split('').drop(extra_symbols).join('').lstrip
      info = @page.css('.theiaPostSlider_preloadedSlide > p')[@i + 1].text
      @i += 1
      @data << {
        actors: actors,
        info: info
      }
    end
    @data
  end
end
