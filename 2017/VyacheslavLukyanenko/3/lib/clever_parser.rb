require 'mechanize'

class CleverParser
  h = 'http://www.theclever.com/15-celebs-you-didnt-know-were-gay-or'
  CLEVER_ACTORS = h + '-bisexual/'.freeze

  attr_reader :message
  attr_reader :bot

  def initialize(message, bot)
    @message = message
    @bot = bot
    @actors_info = []
    @actors = []
  end

  def get_data_from_clever(message)
    i = 0
    feedback = { actor: '', info: '' }
    while i < @actors.count
      if message.text == @actors[i]
        feedback[:actor] = @actors[i]
        feedback[:info] = @actors_info[i]
        feedback
        break
      end
      i += 1
    end
  end

  def make_data_from_clever
    page = Mechanize.new.get(CLEVER_ACTORS)
    page.css('.article-content h2 strong').each do |x|
      @actors << x.text
    end
    page.css('.article-content > p').each do |x|
      @actors_info << x.text
    end
    @actors_info.shift
    @actors_info.shift
    @actors_info.shift
  end
end
