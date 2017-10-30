# class is used for collecting and downloading pages with links
class Battle
  SINGERS_REGEXP = /(\[[^\]]+\]\s)([^\[]*)/m

  def initialize(params)
    @title = params[:title]
    @url = params[:url]
    @text = params[:text]
    @criteria = params[:criteria] ? /\s#{params[:criteria]}\s/i : /[[:alnum:]]/
    @singers = {}
    calculate
  end

  def print
    puts "#{@title} - #{@url}"
    @singers.each do |name, counter|
      puts "#{name} - #{counter}"
    end
    puts "#{winner} WINS! \n \n"
  end

  def winner
    @singers.max_by { |_, value| value }[0]
  end

  private

  def calculate
    self.class.get_singers(@title).each { |s| @singers[s] = 0 }
    @text.scan(SINGERS_REGEXP).each do |group|
      round_name = group[0]
      round_text = group[1]
      @singers.each_key do |name|
        if round_name.include?(name)
          @singers[name] += round_text.scan(@criteria).count
        end
      end
    end
  end

  class << self
    def get_singers(title)
      title.split(/\svs\.?\s/i).map { |s| s.split('(').first.strip }
    end
  end
end
