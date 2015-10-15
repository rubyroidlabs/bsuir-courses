loop {
  for i in (0..28)
    File.open("Dormer/"+i.to_s()+".txt") do |f|
      f.each_line do |line|
        print line
      end
      sleep(0.1)
      system "clear"
    end
  end
}