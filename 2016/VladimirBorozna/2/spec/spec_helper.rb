require "bundler"
Bundler.require(:default, :test)
require_all "lib"

require "webmock/rspec"
require_relative "support/vcr"
require_relative "support/inbound_request_recorder"
