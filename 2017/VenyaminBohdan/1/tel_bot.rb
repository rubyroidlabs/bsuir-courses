require_relative 'lib_telegram.rb'

text = 'Input "upload" for upload information to file'
talking = Telgrm.new

if File.zero?('actors.txt')
  talking.notification(text)
end

talking.dialog
