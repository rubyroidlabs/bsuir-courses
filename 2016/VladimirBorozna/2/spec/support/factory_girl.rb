RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end

# factory_girl doesnt work without this inctance methods
module Ohm
  class Model # :nodoc:
    alias assign_id id=
    alias save! save

    def id=(id)
      assign_id(id)
    end
  end
end
