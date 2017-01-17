 require './ParseOptions'
 require './Process'
 
 time = Time.now.asctime
 options = Options.parse(ARGV)
 Dir.mkdir(options.directory + "/#{time}")
 Dir.glob(options.directory + "/*.jpg") do |image|
   Images.processing(image,options, time)
 end
  puts "Done! See result folder in directory you note" 
  puts "      Or in ./../project_folder/cats, if you don't use params"
 
