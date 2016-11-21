# work with redis
module Database
  def self.set(key, data)
    params = Redis.new.get(key)
    if params
      updated_params = JSON.parse(params).merge(data)
    else
      updated_params = data
    end
    json_params = updated_params.to_json
    Redis.new.set key, json_params
    updated_params
  end

  def self.get_db(key)
    if (params = Redis.new.get(key)) != "null"
      JSON.parse(params)
    end
  end

  def self.delete_key(key)
    params = Redis.new.get(key)
    updated_params = JSON.parse(params)
    updated_params.clear
    json_params = updated_params.to_json
    Redis.new.set key, json_params
    updated_params
  end
end
