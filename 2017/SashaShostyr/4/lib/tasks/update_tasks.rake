require_relative 'converter'

desc 'update rates'
task update_rates: :environment do
  Converter.new.write_result
end
