require_relative 'lib_tel_two.rb'

text = 'Input "upload" for upload information to file'
talking = Telgrm.new

talking.notification(text)

talking.dialog
