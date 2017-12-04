namespace :currency do
  desc "get_currency_rate"
  task get_currency_rate: :environment do
    require_relative 'parser'
    class Currency
    	def self.get_currency
    		btc_to_usd = Parser.get_info('https://ru.investing.com/currencies/btc-usd')
    		btc_to_usd = btc_to_usd.tr('.','').tr(',','.').to_f
    		usd_to_byn = Parser.get_info('https://ru.investing.com/currencies/usd-byn')
    		usd_to_byn = usd_to_byn.tr(',','.').to_f
    		btc_to_bonstics = (btc_to_usd * usd_to_byn / 15).round(4)
    		File.open("#{Rails.root.join 'config','settings.yml'}", "w+") {|f|
    			f.write("currency: #{btc_to_bonstics}")
    		}
    		p btc_to_bonstics
    	end
    end

    Currency.get_currency

  end

end
