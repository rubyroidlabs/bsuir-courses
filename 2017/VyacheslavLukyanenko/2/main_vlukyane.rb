require_relative 'page_skrapping'

name = ENV['NAME']
criteria = ENV['CRITERIA']

new_request = Rap_playground.new
new_request.load_battles_links(criteria, name)
