require './analyzer'
require './criterion_err'

analyzer = Analyzer.new

puts "\n"
puts '*** King of the Dot ***'
puts '- Пошумим, БЛ***!'
begin
  analyzer.run
rescue CriterionError => e
  puts e
end
