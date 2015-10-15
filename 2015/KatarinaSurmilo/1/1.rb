frames = []

sorted_filepathes = Dir[File.expand_path('frames/*.txt')].sort_by {|filepath| filepath.split('/').last.to_i }

sorted_filepathes.each do |filepath|
  frame = File.readlines(filepath).join
  frames.push frame
end

3.times do
  frames.each do |frame|
    puts frame
    sleep 0.2
    system "clear"
  end
end
