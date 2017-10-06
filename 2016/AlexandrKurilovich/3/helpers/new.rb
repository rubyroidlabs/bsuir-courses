class NewHelp # :nodoc:
  def initialize(redis, session, params)
    @redis = redis
    @session = session
    @params = params
  end

  def text
    @params[:word]
  end

  def word
    text["name"]
  end

  def word_data
    "#{word}.#{current_time}.#{@session['user']}"
  end

  def current_time
    DateTime.now.strftime("%Y-%m-%d %H:%M")
  end

  def valid?
    word.chars.select { |x| x =~ /[,!:;\"-]/ }.size > 1 || word.include?(".")
  end

  def keys
    @redis.keys.select { |x| x.include?("phrase:") }
  end

  def ind
    keys.map { |k| k.split(":")[1] }
  end

  def phrase_index
    ind.empty? ? 1 : ind.max.to_i + 1
  end

  def save
    wordes = [word_data]
    @redis.set("phrase:#{phrase_index}", wordes.to_json)
  end
end
