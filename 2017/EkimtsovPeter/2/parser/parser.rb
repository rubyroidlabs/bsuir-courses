require 'mechanize'
require_relative 'classes/linker'
require_relative 'classes/array'
require_relative 'classes/hash_output'

hsh_links = Linker.new
hsh_links.page_get
output_hsh = HashOutput.new(hsh_links.arr_links)
output_hsh.hash_complete
