def readFile(nameOfFile)
  file = File.open(nameOfFile)
  a = Array.new
  file.each {|line| a.push(line)}

  n = 65
  loop do
    system "clear"

    indent = ' '

    if n >= 0
      indent *= n
      a.each{|line| puts indent + line}
    else
      a.each{|line| puts line[-n..-1]}
    end
    n -= 1

    if n == -100
      n = 65
    end

    sleep 0.03
  end

end


readFile("2.txt")
