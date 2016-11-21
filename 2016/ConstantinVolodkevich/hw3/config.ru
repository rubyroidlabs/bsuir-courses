require File.expand_path '../server.rb', __FILE__
JWT_SECRET = 'testApp'
JWT_ISSUER = 'gameApp'
run Rack::URLMap.new({
'/' => Public,
'/api' => Api
})
