class ShowHelp # :nodoc:
  def initialize(redis, session, params, json_on = false)
    @redis = redis
    @session = session
    @params = params
    @all_phrase = all_phrase
    @json_on = json_on
  end

  def phrase_id
    @params[:id]
  end

  def phrase_from_redis
    @redis.get("phrase:#{phrase_id}")
  end

  def valid_params?
    phrase_id.nil? || phrase_from_redis.nil?
  end

  def all_phrase
    JSON.parse(phrase_from_redis) unless valid_params?
  end

  def phrase
    @all_phrase.map { |ph| ph.split(".").first }
  end

  def info_show
    current_info = []
    @all_phrase.size.times do |t|
      @t = t
      current_info.push generate_array
    end
    current_info
  end

  def user_last?
    last_name == @session["user"]
  end

  def valid_word?
    word.chars.select { |x| x =~ /[,!:;-]/ }.size > 1 || word.include?(".")
  end

  def current
    @all_phrase[0..@t].map { |x| x.split(".") }
  end

  def current_words
    @all_phrase[0..@t].map { |x| x.split(".").first }
  end

  def phrase_without_last_word
    current_words[0...-1].join(" ")
  end

  def last_date
    current.last[1]
  end

  def last_name
    current.last.last
  end

  def generate_array
    [phrase_without_last_word, current_words.last, last_date, last_name]
  end

  # for post

  def current_time
    DateTime.now.strftime("%Y-%m-%d %H:%M")
  end

  def word
    text = @params[:word]
    text["name"]
  end

  def word_data
    "#{word}.#{current_time}.#{@session['user']}"
  end

  def phrase_for_post
    JSON.parse(@redis.get("phrase:#{@params[:word]['id']}"))
  end

  def save
    phr = phrase_for_post
    phr.push word_data
    @redis.set("phrase:#{@params[:word]['id']}", phr.to_json)
    @session["flash"] = "Слово успешно добавлено" unless @json_on
  end
end
