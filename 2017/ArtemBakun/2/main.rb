require 'mechanize'
require_relative 'parser'
require_relative 'rapper'

l = Parser.new
l.parser

r = Rapper.new(l.mc_left, l.mc_right, l.b_links)

r.get_answer
