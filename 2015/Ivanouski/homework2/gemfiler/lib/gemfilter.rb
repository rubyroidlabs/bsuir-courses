class GemFilter
  def self.filter(hash, option, version)
    hash.each do |i|
      temp = i['number']
      if option == '<' && i['number'] < version
        puts (i['number']).red
      elsif option == '>' && i['number'] > version
        puts (i['number']).red
      elsif option == '>=' && i['number'] >= version
        puts (i['number']).red
      elsif option == '~>' && i['number'] >= version &&
            temp[2] == version[2] && temp[0] == version[0]
        puts (i['number']).red
      else
        puts i['number']
      end
    end
  end

  def self.filter2(hash,
                   option1,
                   version1,
                   option2,
                   version2)
    hash.each do |i|
      if option1 == '>=' && option2 == '<' &&
         i['number'] >= version1 && i['number'] < version2
        puts (i['number']).red
      elsif option1 == '>' && option2 == '<' &&
            i['number'] > version1 && i['number'] < version2
        puts (i['number']).red
      else
        puts i['number']
      end
    end
  end
end
