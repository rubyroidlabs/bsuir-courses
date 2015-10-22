class GemFilter                                     # comment just for Hound
  def self.filter(hash, option, version)
    hash.each do |i|                                # comment just for Hound
      temp = i['number']
      if option == '<' &&
         i['number'] < version
        puts (i['number']).red                      # comment just for Hound
      elsif option == '>' &&
            i['number'] > version
        puts (i['number']).red                      # comment just for Hound
      elsif option == '>=' &&
            i['number'] >= version
        puts (i['number']).red                      # comment just for Hound
      elsif option == '~>' &&
            i['number'] >= version &&
            temp[2] == version[2] &&
            temp[0] == version[0]
        puts (i['number']).red                      # comment just for Hound
      else
        puts i['number']                            # comment just for Hound
      end
    end
  end

  def self.filter_long(hash, option1, version1, option2, version2)
    hash.each do |i|                                # comment just for Hound
      if option1 == '>=' &&
         option2 == '<' &&
         i['number'] >= version1 &&
         i['number'] < version2
        puts (i['number']).red                      # comment just for Hound
      elsif option1 == '>' &&
            option2 == '<' &&
            i['number'] > version1 &&
            i['number'] < version2
        puts (i['number']).red                      # comment just for Hound
      else
        puts i['number']                            # comment just for Hound
      end
    end
  end
end
