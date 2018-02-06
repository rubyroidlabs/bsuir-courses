# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
agent = Mechanize.new
page = agent.get('https://pokur.su/btc/byn/1')
price_bitcoin = page.search('.input__currency input')[1].attr(:value)
File.open('app/assets/bitcoin.data', 'w+') do |f|
  f.puts(price_bitcoin)
end
Rails.application.initialize!
