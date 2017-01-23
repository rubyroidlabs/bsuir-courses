# extending for IO class
module ImmediatelyIO
  def imm_out(input, stdout)
    system 'clear'
    stdout.puts "#{input}#=> #{yield(input)}"
  end
end
