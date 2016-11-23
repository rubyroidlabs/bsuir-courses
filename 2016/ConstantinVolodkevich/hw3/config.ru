require File.expand_path '../private.rb', __FILE__
require File.expand_path '../public.rb', __FILE__
JWT_SECRET = 'testApp'
JWT_ISSUER = 'gameApp'
run Rack::URLMap.new({
'/' => Public,
'/api' => Api
})
