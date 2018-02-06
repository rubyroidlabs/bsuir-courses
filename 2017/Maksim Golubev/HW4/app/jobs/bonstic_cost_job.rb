class BonsticCostJob < ApplicationJob
  queue_as :default


  def perform
    bonstic_cost = 10.0
    agent = Mechanize.new
    bit_responce = agent.get('https://blockchain.info/ru/ticker')
    bit_curencies = JSON.parse bit_responce.body
    bit_curency = bit_curencies.dig 'USD', 'last'
    nbrb_responce = agent.get('http://www.nbrb.by/API/ExRates/Rates/145')
    bnrb_curencies = JSON.parse nbrb_responce.body
    bnrb_curency = bnrb_curencies.dig 'Cur_OfficialRate'
    BonsticCost.create(cost: (bit_curency * bnrb_curency / bonstic_cost))
  end
end
