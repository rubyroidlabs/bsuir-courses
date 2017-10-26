require './analyzer'
require './criterion_err'

analyzer = Analyzer.new

puts "*** King of the Dot ***\n- Пошумим, БЛ***!"
begin
  analyzer.run
rescue CriterionError => e
  puts e
end
