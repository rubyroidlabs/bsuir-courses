require 'microsoft_translator'
require 'sentimental'

require_relative('ms_data.rb')

class MSAnalysis
  def initialize
    begin
      @translator = MicrosoftTranslator::Client.new(ID, KEY)
    rescue RestClient::BadRequest
      puts 'Microsoft Translator Id & key required'
      puts 'view readme for help'
      exit
    end
    Sentimental.load_defaults
    @analyzer = Sentimental.new
  end

  def translate(comment)
    @translator.translate(comment, 'ru', 'en', 'text/plain')
  end

  def analyze(comment)
    tcomment = translate(comment)
    @analyzer.get_sentiment(tcomment)
  end
end
