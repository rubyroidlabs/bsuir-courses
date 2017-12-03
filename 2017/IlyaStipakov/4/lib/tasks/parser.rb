require 'mechanize'
require 'json'

class Parser
  def parser
    mechanize = Mechanize.new
    page = mechanize.get('https://pokur.su/btc/byn/1/')
    puts @bitkoin = page.at('tbody tr td').text.strip.to_f
  end

  def write
    parser
    puts @BTC = @bitkoin/15
    puts @BNC = 15/@bitkoin
    @data = { btc: @BTC, bns: @BNC }
    File.open('data.json', 'w') do |temp|
      temp.write(@data.to_json)
    end
  end
end

Parser.new.write
