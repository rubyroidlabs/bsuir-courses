require "date"

# Add a class method which returns the current utc date
class Date # :nodoc:
  class << self # :nodoc:
    def today_utc
      Time.now.utc.to_date
    end
  end
end
