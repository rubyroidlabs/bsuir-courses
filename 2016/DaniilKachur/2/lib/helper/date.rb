module Helper
  # useful methods for Date processing
  module Date
    def time_left
      (user.semester[:finish] - user.semester[:start]).to_i
    end

    def new_date
      Date.new(*Date._parse(text).values)
    end

    def valid_date?
      if Date._iso8601(text).empty?
        send_message("Не надо нам вашу дату, у нас есть своя YYYY-MM-DD")
      elsif new_date.year == Date.today.year
        yield(new_date)
      else
        send_message("Живи в настоящем, #{Date.today.year} году")
      end
    end
  end
end
