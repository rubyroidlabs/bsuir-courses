require_relative 'boot'

require 'rails/all'

# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hw4
  class Application < Rails::Application
    config.load_defaults 5.1
  end
end
