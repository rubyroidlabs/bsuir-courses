require 'mechanize'

class ExchangeRates
  LINK = 'https://myfin.by/crypto-rates/bitcoin'.freeze
  BONSTICK_PRICE = 7.5

  def self.take
    agent = Mechanize.new
    page = agent.get(LINK)
    rate = page.css('.birzha_info_head_rates').text.split.first.to_f
    rate /= BONSTICK_PRICE
    rate.ceil
  end
end
