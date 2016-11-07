require "json"
require "redis"

class Database
  #Class for working with database
  def initialize
    @database = Redis.new
  end

  def update(data, user_id)
    user = user(user_id)
    keys = data.keys
    keys.each { |key| user[key.to_s] = data[key] }

    save_user(user, user_id)
  end

  def token
    @database.get("token")
  end

  def user(user_id)
    JSON.parse(@database.get("users"))[user_id.to_s]
  end

  def users
    JSON.parse(@database.get("users"))
  end

  def create_user(user_id)
    user = {
      "subjects" => {},
      "start_date" => '',
      "finish_date" => '',
      "available_days" => '',
      "reminders" => []
    }
    save_user(user, user_id)

    user
  end

  private

  def save_user(user, user_id)
    users = JSON.parse(@database.get("users"))
    users[user_id.to_s] = user

    @database.set("users", users.to_json)
  end
end
