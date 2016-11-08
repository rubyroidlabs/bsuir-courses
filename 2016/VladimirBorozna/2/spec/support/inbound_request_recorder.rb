require "rspec"
require "rack"

FIXTURE_DIR = File.expand_path("../../fixtures/inbound_requests", __FILE__)

# RSpec helpers
module Helpers
  def recorded_request(name)
    fixture_file = File.join(FIXTURE_DIR, "#{name}.env")
    env = Marshal.load(File.read(fixture_file))
    env["rack.input"] = StringIO.new(env["rack.input"])
    Rack::Request.new(env)
  end
end

RSpec.configure do |config|
  config.include Helpers
end
