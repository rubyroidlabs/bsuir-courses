module ExchangeRatesHelper
  def self.btc_to_bst
    Rails.cache.fetch('exchange_rate', expires_in: 1.day) do
      exchange_rate = (RatesParser::FreeCurrencyRates.new.rates / 15).round(2)
      "BTC = #{exchange_rate} BST"
    end
  end
end
