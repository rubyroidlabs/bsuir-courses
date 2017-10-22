require_relative('fight')

name = ENV['NAME']
criteria = ENV['CRITERIA']

if name.nil?
  name = 'lyrics'
  Fight.new.start_figths(name, criteria)
else
  Fight.new.start_figth(name, criteria)
end
