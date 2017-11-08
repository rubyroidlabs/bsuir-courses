require 'mechanize'
require_relative 'classes/grabber'
require_relative 'classes/array'
require_relative 'classes/names_texts_splitter'
require_relative 'classes/console'
require_relative 'classes/counter'

links = Grabber.new
names_and_texts = NamesTextsSplitter.new(links.grab)
names_and_texts.complete_names_links
