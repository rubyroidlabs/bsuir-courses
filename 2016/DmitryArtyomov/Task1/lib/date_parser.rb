require 'date'

# Module helping to parse user-input date
module DateParser
  class << self
    private

    def no_year?(date_arr)
      date_arr.count == 2
    end

    def push_year(date_arr)
      date_arr.push(Date.today.year.to_s)
    end

    def not_full_year?(date_arr)
      date_arr[2].length <= 2 && date_arr[0].to_i <= 31
    end

    def date_process_year(date_arr)
      if no_year?(date_arr)
        push_year(date_arr)
      elsif not_full_year?(date_arr)
        date_arr.reverse!
        date_arr[0] = '2' + '0' * (3 - date_arr[0].length) + date_arr[0]
      end
      date_arr
    end

    def prepare_date(date_string)
      date_split = date_string.sub(/^[\s.-]+/, '').sub(/[\s.-]+$/, '')
                              .split(/[\s.-]/)
      return nil if date_split.count < 2
      date_process_year(date_split).join('.')
    end

    public

    def parse(date_string)
      date = prepare_date(date_string)
      return nil if date.nil?
      Date.parse(date).to_time.to_i
    rescue ArgumentError
      nil
    end

    def valid_date?(date_string)
      !parse(date_string).nil?
    end
  end
end
