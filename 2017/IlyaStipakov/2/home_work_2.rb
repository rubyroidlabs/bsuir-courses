require_relative 'parser'
require 'mechanize'
require 'date'
require 'json'

agent = Mechanize.new
parser = Parser.new

page = agent.get('https://genius.com/artists/King-of-the-dot')
link = page.link_with(text: /\Show all songs by King of the Dot/)
pages = link.click

pages.links.each do |battle|
  info_array = Array[]
  next unless battle.text.strip.index('vs')
  page = battle.click
  parser.link_sort(page) { |x| info_array.push(x) }
  head_post = info_array[0]
  text = info_array[1]
  mc_first = info_array[2]
  mc_second = info_array[3]
  info_array.clear
  parser.line_section(text, mc_first, mc_second) { |x| info_array.push(x) }
  left_str = info_array[0]
  right_str = info_array[1]
  parser.print_result(head_post, mc_first, mc_second, left_str, right_str)
end
