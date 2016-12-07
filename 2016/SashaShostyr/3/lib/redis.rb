# Work with Database
module Database
  def self.set(key, data)
    params = Redis.new.get(key)
    updated_params = if !params.nil?
                       JSON.parse(params).merge(data)
                     else
                       data
                     end
    json_params = updated_params.to_json
    Redis.new.set key, json_params
    updated_params
  end

  def self.get_db(key)
    if !(params = Redis.new.get(key)).nil?
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
