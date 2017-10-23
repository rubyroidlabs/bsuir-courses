require_relative 'page_skrapping'

name1 = ENV['NAME']
criteria = ENV['CRITERIA']

new_request = RapPlayground.new
new_request.load_battles_links(criteria, name1)
