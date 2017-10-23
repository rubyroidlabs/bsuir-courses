class Parser
  def link_sort(page)
    head = page.at('h1').text.strip
    text = page.at('p').text.strip
    array_featuring = head.split
    switch = true
    mc_left = ' '
    mc_right = ' '
    array_featuring.each do |word|
      if switch
        if word == 'vs'
          switch = false
        else
          mc_left << word.to_s
        end
      else
        mc_right << word.to_s
      end
    end
    arr = Array[]
    arr[0] = head
    arr[1] = text
    arr[2] = mc_left
    arr[3] = mc_right
    return arr
  end

  def line_section(text, mc_left, mc_right)
    text.delete! ' '
    array = text.split
    left = true
    right = true
    str_left = ' '
    str_right = ' '
    number = 1
    array.each do |line|
      first_mc = "[Round#{number}:#{mc_left}]"
      first_mc.delete! ' '
      second_mc = "[Round#{number}:#{mc_right}]"
      second_mc.delete! ' '
      if line.to_s == first_mc
        left = true
        right = false
      elsif line.to_s == second_mc
        left = false
        right = true
        number += 1
      end
      if left == true
        str_left << line
      elsif right == true
        str_right << line
      end
    end
    arr = Array[]
    arr[0] = str_left
    arr[1] = str_right
    return arr
  end

  def print_result(head, mc_left, mc_right, str_left, str_right)
    puts head
    print "#{mc_left} - #{str_left.size}\n"
    print "#{mc_right} - #{str_right.size}\n"
    if str_left.size > str_right.size
      print "#{mc_left} WINS!!!\n"
    else
      print "#{mc_right} WINS!!!\n"
    end
    puts '-----------------------------------------------'
  end
end
