class Song
  TITLE_CLASS = '.header_with_cover_art-primary_info-title'.freeze
  TEXT_CLASS = '.lyrics'
  def initialize(agent)
	  @agent = agent
  end

  def result(href)
    page = @agent.get(href)
    singers_names = singers(page)
    count = counter(page)
    {singers:
      [{name: singers_names.first, count: count.first},
       {name: singers_names.last, count: count.last}],
     winner: winner
    }
  end



  private



  def singers(page)
    title = song.at(TITLE_CLASS).text.split(/vs|Vs/)
    [title.first.strip, title.last.strip]
  end

  def counter(page)
    rounds = page.at(TEXT_CLASS).text.split(/\[+[\w\s\:]+\]+/)
    first = rounds[1..6].select.with_index {|words, index| index.odd?}
    second = rounds[1..6].select.with_index {|words, index| index.even?}
    [first, second].each do |array|
      array.inject(0) {|memo, element| memo += element.scan(/\w+/).join.size}
    end
  end
end