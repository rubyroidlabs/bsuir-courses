# encoding: utf-8
# class for specialized output
# gem Sentimental works only with enlish text
class Printer
  def initialize(comments_hash)
    @comments_hash = comments_hash
    data = retrieve_data('data.yaml')
    @translator = MicrosoftTranslator::Client.new(data['id'], data['secret'])
    Sentimental.load_defaults
    Sentimental.threshold = 0.1
    @analyzer = Sentimental.new
  end

  def sentiment_output
    @comments_hash.each do |name, comments|
      puts name.colorize(:blue)
      puts '====='
      puts "Не найдено ни одного отзыва о преподователе\n" if comments.empty?
      comments.each do |comment|
        en_comm = @translator.translate(comment, 'ru', 'en', 'text/html')
        mood = @analyzer.get_sentiment en_comm
        case mood
        when :positive
          puts comment.colorize(:green)
        when :negative
          puts comment.colorize(:red)
        else
          puts comment
        end
      end
    end
  end

  private

  def retrieve_data(file)
    data = {}
    File.open(file, 'r') { |io| data = YAML::load(io.read) }
  end
end
