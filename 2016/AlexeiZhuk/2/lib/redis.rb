require 'redis'
DB_REDIS_KEY = "db"
#Redis.new.del DB_REDIS_KEY

def save_to_db( data )            
	params = Redis.new.get( DB_REDIS_KEY ) 
	if params
		updated_params = JSON.parse(params).merge( data )
	else 
		updated_params = data
	end
	json_params = updated_params.to_json
	Redis.new.set DB_REDIS_KEY, json_params
	updated_params
end


def get_from_db
	if (params = Redis.new.get( DB_REDIS_KEY )) != 'null'
		JSON.parse(params)
	else 
		""
	end
end

def delete_db_key( key )
	params = Redis.new.get( DB_REDIS_KEY ) 
	if params
		updated_params = JSON.parse(params)
		updated_params.delete( key ) 
		json_params = updated_params.to_json
		Redis.new.set DB_REDIS_KEY, json_params
		updated_params
	end
end



test = {test_lol: "1", test2: "2123123"} 


#byebug
save_to_db( test ) 
delete_db_key( 'test_lol' )

puts get_from_db