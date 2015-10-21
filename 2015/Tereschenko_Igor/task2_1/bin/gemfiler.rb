Dir['../lib/*.rb'].each {|f| require_relative(f)}

name = ARGV[0].to_s 
ARGV.shift

input = Input_parser.new(name, ARGV)
versions = Version_finder.new(name)
output = Parser.new(versions.vget, input.operators)
output.output
