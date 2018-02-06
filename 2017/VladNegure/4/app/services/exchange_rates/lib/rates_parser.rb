module RatesParser
class FreeCurrencyRates
  PATH = 'https://freecurrencyrates.com/ru/convert-BTC-BYN'.freeze

  def rates
    @rates ||= parse
  end

  private

  def parse
    page = Mechanize.new.get(PATH)
    page.search('#value_to').first.attributes['value'].value.to_f
  end
end
end
