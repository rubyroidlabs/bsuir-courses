class Colorizer
  def initialize(reviews)
    @reviews = reviews
    @characteristics = YAML.load_file('../keywords.yml')
  end

  def view_colored_reviews # assignment branch condition
    @reviews.each do |r|
      @characteristics['positive'].each do |c|
        if r.include? c
          puts r.green, "\n", '===', "\n"
          @reviews.delete(r)
          break
        end
      end
      @characteristics['negative'].each do |c|
        if r.include? c
          puts r.red, "\n", '===', "\n"
          @reviews.delete(r)
          break
        end
      end
    end
    @reviews.each { |r| puts r, "\n", '===', "\n" }
  end
end
