require 'yaml'
require 'rest-client'
require 'json'

response = RestClient.get('https://free.currencyconverterapi.com/api/v5/convert?q=BTC_BYR&compact=y')
pars = JSON.parse(response)
btc_byr = pars['BTC_BYR']['val']
puts btc_byr
File.open('btc_byr.yml', 'w') { |f| f.write(btc_byr.to_yaml) }
