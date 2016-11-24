require_relative "word.rb"

#Class Phrase
class Phrase
  def initialize(options = {})
    @client = options[:client] ? options[:client] : Mongo::Client.new(["127.0.0.1:27017"], database: "phrases")
    @collection = @client[:phrases]
  end

  def insert_one(user_id, date)
    phrase = {
        words: [],
        user_id: user_id,
        date: date
    }

    @collection.insert_one(phrase).inserted_ids.first
  end

  def add_word(phrase_id, word_id)
    phrase = @collection.find({_id: phrase_id}).first
    phrase[:words].push(word_id)

    result = @collection.update_one({_id: phrase_id}, {"$set" => {words: phrase[:words]}})

    p result
  end

  def find_all
    word = Word.new(client: @client)

    @phrases = @collection.find({}).map do |phrase|
      phrase[:words] = phrase[:words].map do |word_id|
        word.find_by_id(word_id).to_h
      end

      phrase
    end
  end

  def find_by_id(phrase_id)
    word = Word.new(client: @client)

    phrase = @collection.find({_id: phrase_id}).first
    phrase[:words] = phrase[:words].map do |word_id|
        word.find_by_id(word_id).to_h
    end

    phrase
  end
end
