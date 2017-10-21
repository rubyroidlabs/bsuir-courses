require 'mechanize'
require_relative 'kotd2'

page = Kotd2.start
Kotd2.link_run(page)
