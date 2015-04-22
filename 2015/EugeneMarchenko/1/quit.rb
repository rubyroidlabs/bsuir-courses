def quit?
  begin
    # See if a 'Q' has been typed yet
    while c = STDIN.read_nonblock(1)
      #puts "I found a #{c}"
      return true if c == 'q'
    end
    # No 'Q' found
    false
  rescue Errno::EINTR
    #puts "Well, your device seems a little slow..."
    false
  rescue Errno::EAGAIN
    # nothing was ready to be read
    #puts "Nothing to be read..."
    false
  rescue EOFError
    # quit on the end of the input stream
    # (user hit CTRL-D)
    #puts "Who hit CTRL-D, really?"
    true
  end
end