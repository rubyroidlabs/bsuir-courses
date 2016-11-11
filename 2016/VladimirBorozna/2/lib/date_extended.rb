require "date"

class Date
  class << self
    def today_utc
      Time.now.utc.to_date
    end
  end
end
