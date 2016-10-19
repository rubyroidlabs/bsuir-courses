currStr = "\0"
strArr = []

while (currStr != "\n")  do
  currStr = gets
  strArr.push( currStr.chomp )
  if (currStr.chomp == '+') or (currStr.chomp == '-') or (currStr.chomp == '*') or (currStr.chomp == '/') or (currStr.chomp == '!')
    if (currStr.chomp == '!')
      strArr.pop
      onesNum = strArr.pop.to_i
      a = tempa = strArr.pop.to_i

      currOnesNum = 0
      shiftsAmount = 0

      while (currOnesNum != onesNum)
        if (tempa % 2 == 1)
          currOnesNum += 1
        end

        tempa /= 2
        shiftsAmount += 1
      end

      strArr.push( (a >> shiftsAmount << shiftsAmount).to_s )
    else
      op = strArr.pop
      b = strArr.pop
      a = strArr.pop

      strArr.push( eval(a + op + b).to_s );
    end
  end
end

puts('#=>' + strArr[0])	