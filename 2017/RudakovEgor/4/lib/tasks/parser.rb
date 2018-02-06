require 'mechanize'
require 'json'

class Parser
  def parse_data
    agent = Mechanize.new
    page = agent.get('https://pokur.su/btc/byn/1/')
    @btc = (page.at('input[data-role="secondary-input"]')['value'].to_f/15).to_s
    new_page = agent.page.link_with(href: '/byn/btc/1/').click
    @bnk = (new_page.at('input[data-role="secondary-input"]')['value'].sub(/,/, '.').to_f*15).to_s
    @data = { bitcoin: @btc, bonstick: @bnk }
  end

  def write_data
    parse_data
    File.open('data.json', 'w') do |temp|
      temp.write(@data.to_json)
    end
  end
# finance.bitcoin = @btc
# finance.bonstick = @bnk
end

Parser.new.write_data
