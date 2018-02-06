module CurrencyData
  # 'https://currencylayer.com/dashboard'
  class CurrencyRateParser
    ACCESS_KEY = 'df15a42c2de9873dee619103b7005fa3'.freeze
    WEBAPI = 'http://apilayer.net/api/'.freeze
    CHARS_AFTER_DOT = 6
    ONE_FIFTEENTH = 0.066667

    def initialize(endpoint, currencies, source)
      @endpoint = endpoint
      @currencies = currencies
      @source = source
    end

    def request
      url = url_geting
      info = get_info(url)
      rate = get_rate(info)
      coefficients = get_coefficients(rate[:bitcoin],
                                      rate[:bel_rub], rate[:bonstick])
      get_results(coefficients.first, coefficients.last)
    end

    private

    def url_geting
      WEBAPI + @endpoint + '?access_key=' + ACCESS_KEY +
        '&currencies=' + @currencies + '&source=' + @source
    end

    def get_info(url)
      main = Curl::Easy.perform(url)
      @doc = Nokogiri::HTML(main.body)
      info = @doc.xpath('//text()').map(&:text)
      parsed_info(info)
    end

    def parsed_info(info)
      info = info.join.delete('"').split(/{|}/).last.strip
      info.split(',').map { |item| item.split(':') }
    end

    def get_rate(info)
      btc = info.assoc("#{@source}BTC").last.to_f
      byn = info.assoc("#{@source}BYN").last.to_f
      bon = ONE_FIFTEENTH
      { bitcoin: btc, bel_rub: byn, bonstick: bon }
    end

    def get_coefficients(btc, byn, bon)
      coeff1 = (bon * byn / btc).round(CHARS_AFTER_DOT)
      coeff2 = (btc / byn / bon).round(CHARS_AFTER_DOT)
      [coeff1, coeff2]
    end

    def get_results(coeff1, coeff2)
      result1 = "1 BTC = #{coeff1} BON"
      result2 = "1 BON = #{coeff2} BTC"
      [result1, result2]
    end
  end

  def self.start
    currency_rate_parser = CurrencyRateParser.new('live', 'BTC,BYN', 'USD')
    currency_data = currency_rate_parser.request
    currency_data
  end
end
