class IndexHelp # :nodoc:
  def initialize(redis, session)
    @redis = redis
    @session = session
  end

  def keys
    @redis.keys.select { |x| x.include?("phrase:") }
  end

  def phrases
    keys.map do |k|
      @key = k
      [text, k.split(":")[1], check_user]
    end
  end

  def all_data
    JSON.parse(@redis.get(@key))
  end

  def text
    all_data.map { |w| w.split(".").first }
  end

  def last_user
    all_data.last.split(".").last
  end

  def check_user
    last_user == @session["user"]
  end
end
