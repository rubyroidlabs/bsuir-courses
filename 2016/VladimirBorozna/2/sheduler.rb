require "clockwork"
require "require_all"
require_all "lib/workers"

# Module for clock proccess
module Clockwork
  every(10.hour, "Send notificaionts") { NotifyWorker.perform_async }
end
