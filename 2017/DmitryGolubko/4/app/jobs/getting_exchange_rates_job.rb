require_relative 'get_currency_rate'

class GettingExchangeRatesJob < ApplicationJob
  queue_as :default

  def perform()
    
  end
end
