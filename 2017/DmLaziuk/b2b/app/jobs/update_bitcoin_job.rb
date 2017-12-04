require 'yaml'
require 'rest-client'
require 'json'

class UpdateBitcoinJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    puts 'START UpdateBitcoinJob'
    response = RestClient.get('https://free.currencyconverterapi.com/api/v5/convert?q=BTC_BYR&compact=y')
    pars = JSON.parse(response)
    btc_byr = pars['BTC_BYR']['val']
    File.open("#{Rails.root}/config/btc_byr.yml", 'w') do |f|
      f.write(btc_byr.to_yaml)
    end
    ArticlesController.update_btc_byr
    puts 'END UpdateBitcoinJob'
  end
end
