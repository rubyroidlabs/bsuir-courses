class User

  def initialize(options = {})
    @client = options[:client] ? options[:client] : Mongo::Client.new(['127.0.0.1:27017'], :database => 'phrases')
    @collection = Mongo::Client.new(['127.0.0.1:27017'], :database => 'phrases')[:users]
  end

  def get_client
    @client
  end

  def insert_one(name, username, password)
    @collection.insert_one({name: name, username: username, password: password})
  end

  def is_exist(username)
    @collection.find({username: username}).count > 0
  end

  def check_password(username, password)
    user = @collection.find({username: username}).first

    user[:password] == password
  end

  def find_by_username(username)
    @collection.find({username: username}).first
  end

  def find_by_id(id)
    @collection.find({_id: id}).first
  end

end
