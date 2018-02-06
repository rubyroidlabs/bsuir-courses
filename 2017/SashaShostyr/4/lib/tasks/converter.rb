require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'json'

class Converter
  DOLLAR_RATE = 'https://myfin.by/currency/usd'.freeze
  BITCOIN_RATE = 'https://myfin.by/crypto-rates/bitcoin'.freeze
  BONSTICK_RATE = 15

  def initialize
    @agent = Mechanize.new
  end

  def bitcoin_to_usd
    page = @agent.get(BITCOIN_RATE)
    page.search('.birzha_info_head_rates').first.text.strip.to_f
  end

  def usd_to_byn
    page = @agent.get(DOLLAR_RATE)
    page.search('.table-responsive tr').children[18].text.to_f
  end

  def bitcoin_price
    format('%.2f', usd_to_byn * bitcoin_to_usd / BONSTICK_RATE)
  end

  def bonstick_price
    format('%.5f', BONSTICK_RATE / (usd_to_byn * bitcoin_to_usd))
  end

  def write_result
    data = { bitcoin: bitcoin_price, bonstick: bonstick_price }
    File.open('lib/tasks/data.json', 'w') do |temp|
      temp.write(data.to_json)
    end
  end
end
