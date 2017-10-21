require 'mechanize'
require_relative 'Kotd2'

page = Kotd2.start
Kotd2.link_run(page)
