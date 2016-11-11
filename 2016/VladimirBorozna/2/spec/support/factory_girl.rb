RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end

# Monkey patching
module Ohm
  class Model
    alias assign_id id=
    alias save! save

    def id=(id)
      assign_id(id)
    end
  end
end
