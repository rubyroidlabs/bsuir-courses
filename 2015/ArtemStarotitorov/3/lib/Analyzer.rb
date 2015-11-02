require 'microsoft_translator'
require 'sentimental'

class Analyzer
  def initialize
    file = File.open('../Passwords.txt')
    lines = file.to_a
    client_id = lines.first.delete "\n"
    client_secret = lines.last.delete "\n"
    file.close
    Sentimental.load_defaults
    @analyzer = Sentimental.new
    begin
      @translator = MicrosoftTranslator::Client.new(client_id, client_secret)
    rescue StandardError => exc
      puts exc.message
      exit
    end
  end

  def analyze_review(review)
    text = @translator.translate(review, 'ru', 'en', 'text/html')
    @analyzer.get_sentiment text
  end
end
