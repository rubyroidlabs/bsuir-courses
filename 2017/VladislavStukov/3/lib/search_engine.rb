require_relative 'redis_client'

class SearchEngine

  MIN_MATCH = 4

  def initialize(redis)
    @redis = redis
  end

  def search(name)
    full_match = @redis.name_by_pattern(case_insence(name).to_s)
    return full_match.first if full_match.size == 1
    length = name.length - 1
    result = []
    loop do
      start = 0
      result.clear
      while start + length < name.length
        pattern = name[start..start + length]
        result << @redis.name_by_pattern("*#{case_insence(pattern)}*")
        start += 1
      end
      result = result.flatten
      length -= 1
      break unless length >= MIN_MATCH && result.empty?
    end
    result.uniq.take 5
  end

  def case_insence(pattern)
    pattern.scan(/./).map do |letter|
      if /\w/ =~ letter
        "[#{letter.upcase + letter.downcase}]"
      else
        letter
      end
    end.join
  end
end
