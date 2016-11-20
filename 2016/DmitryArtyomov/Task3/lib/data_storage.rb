require 'redis'
require 'json'
require 'singleton'
require_relative 'secret.rb'

# Class for interaction with Redis cloud server
class DataStorage
  include Singleton

  def initialize
    @redis = Redis.new(
      host: Secret::REDIS_HOST,
      port: Secret::REDIS_PORT,
      password: Secret::REDIS_PASS
    )
  end

  def create_phrase(word, user)
    add_word(count_get, word, user)
  end

  def add_word(phrase_id, word, user)
    phrase = get_phrase(phrase_id)
    phrase = [] if phrase.nil?
    phrase_word = {
      'user' => user,
      'time' => Time.now.to_i,
      'word' => word
    }
    phrase.push(phrase_word)
    set_phrase(phrase_id, phrase)
  end

  def all_phrases
    res = []
    (0..count_get - 1).each do |i|
      res.push(phrase_collect(i))
    end
    res
  end

  def get_phrase(phrase_id)
    data = @redis.get("phrase#{phrase_id}")
    data.nil? ? nil : JSON.parse(data)
  end

  def set_phrase(phrase_id, phrase)
    @redis.set("phrase#{phrase_id}", phrase.to_json)
    count_set(phrase_id + 1) if phrase_id == count_get
    phrase_id
  end

  def count_set(value)
    @redis.set('phrase_count', value.to_s)
    value
  end

  def count_get
    data = @redis.get('phrase_count').to_i
    data.nil? ? count_set(0) : data
  end

  def delete_phrase(phrase_id)
    @redis.del("phrase#{phrase_id}")
  end

  def phrase?(phrase_id)
    @redis.exists("phrase#{phrase_id}")
  end

  def phrase_collect(phrase_id)
    phrase = get_phrase(phrase_id)
    return '' if phrase.nil?
    result = []
    phrase.each do |word_data|
      result.push(word_data['word'])
    end
    result.join(' ')
  end

  def time(word_data)
    Time.at(word_data['time']).getlocal('+03:00').strftime('%d.%m.%Y %H:%M')
  end

  def phrase_history(phrase_id)
    phrase = get_phrase(phrase_id)
    return '' if phrase.nil?
    result = []
    steps = phrase_steps(phrase)
    phrase.each.with_index do |word_data, i|
      result.push(
        "#{word_data['user']} (#{time(word_data)}): \"#{steps[i]}\""
      )
    end
    result.reverse
  end

  def phrase_steps(phrase)
    result = ['']
    phrase.each do |word_data|
      result.push(
        "#{result.last.sub('<b>', '').sub('</b>', '')}"\
        " <b>#{word_data['word']}</b>"
      )
    end
    result.drop(1)
  end

  def user_can_write?(phrase_id, user)
    return false unless phrase?(phrase_id)
    return false unless user
    get_phrase(phrase_id).last['user'] != user
  end
end
