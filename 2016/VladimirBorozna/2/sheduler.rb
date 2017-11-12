require "clockwork"
require "require_all"
require_all "lib/workers"
require_relative "seeds"

# :nodoc:
module Clockwork
  every(24.hours, "Send notificaionts") { NotifyWorker.perform_async }
end
