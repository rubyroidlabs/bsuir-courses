class Print
  def initialize
    @keywords = YAML.load_file('keywords.yml')
  end

  def mood(comment)
    positive = negative = 0
    @keywords['positive'].each do |word|
      positive += Unicode::downcase(comment).scan(word).count
    end
    @keywords['negative'].each do |word|
      negative += Unicode::downcase(comment).scan(word).count
    end
    positive <=> negative
  end

  def print(teachers, comments)
    puts "#{teachers}\n ====="
    if case estimate(comments[i])
      when -1 then
        puts "#{comments[i]}".red
      when 1 then
        puts "#{comments[i]}".green
      else
        puts "#{comments[i]}"
      end
      puts
    end
    else
      puts 'Sorry, comments are not found'
      puts
      return
  end
end
