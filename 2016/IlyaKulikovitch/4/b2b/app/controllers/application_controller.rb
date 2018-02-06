class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :danger, :info
  @file = File.read('app/assets/bitcoin.json')
end
