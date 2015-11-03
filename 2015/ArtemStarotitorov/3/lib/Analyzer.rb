require 'yaml'
require 'microsoft_translator'
require 'sentimental'

class Analyzer
  def initialize
    data = YAML.load_file('../config.yml')
    client_id = data['CLIENT_ID']
    client_secret = data['CLIENT_SECRET']
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
