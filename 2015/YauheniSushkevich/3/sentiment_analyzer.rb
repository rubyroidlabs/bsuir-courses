require 'unirest'

# Process sentiment analyz of text
# using Russian Sentiment Analyzer webservice
class SentimentAnalyzer
  SENTIMENT_ANALYZER_URL = 'https://russiansentimentanalyzer.p.mashape.com/ru/sentiment/polarity/json/'

  def self.analyze(text)
    hash = { text: text, output_format: 'json' }
    response = Unirest.post(
      SENTIMENT_ANALYZER_URL,
      headers: {
        'X-Mashape-Key' => 'ATnw1WsaYGmshJmwDa5jb641h3wlp1wtOK8jsnp6SNFyrtR5pz',
        'Content-Type' => 'application/json',
        'Accept' => 'text/plain'
      },
      parameters: hash.to_json)
    response.body['sentiment']
  end
end
