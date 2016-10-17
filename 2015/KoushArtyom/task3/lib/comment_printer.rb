require 'yaml'
require 'colorize'
class CommentPrinter
  def initialize(lectors_and_comments, bsuir, keywords)
    @lectors_and_comments = lectors_and_comments
    @bsuir = bsuir
    @keywords = keywords
  end

  def print
    @lectors_and_comments.each do |h|
      printer(h[:lector], h[:comments])
      @bsuir.delete(h[:lector])
    end
    @bsuir.each do |t|
      printer(t)
    end
  end

  private

  def printer(name, comments = nil)
    n = p = 0
    puts name
    puts '============================================================'
    if comments.nil?
      puts "Не найдено отзывов \n \n"
    else
      comments.each do |c|
        n = 0
        @keywords['negative'].each do |word|
          n += 1 if c.include?(word)
        end
        p = 0
        @keywords['positive'].each do |word|
          p += 1 if c.include?(word)
        end
        if p > n
          puts c.green + "\n \n"
        elsif p < n
          puts c.red + "\n \n"
        else
          puts c + "\n \n"
        end
      end
    end
  end
end
