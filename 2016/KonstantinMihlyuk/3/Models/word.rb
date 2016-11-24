require_relative "user.rb"

# Class Word
class Word
  def initialize(options = {})
    @client = options[:client] ? options[:client] : Mongo::Client.new(["127.0.0.1:27017"], database: "phrases")
    @collection = @client[:words]
  end

  def insert_one(user_id, text, date)
    word = {
      owner: user_id,
      text: text,
      date: date
    }

    @collection.insert_one(word).inserted_ids.first
  end

  def find_by_id(word_id)
    word = @collection.find(_id: BSON::ObjectId(word_id)).first
    user_id = word[:owner]
    word[:owner] = User.new(client: @client).find_by_id(BSON::ObjectId(user_id))

    word
  end
end
