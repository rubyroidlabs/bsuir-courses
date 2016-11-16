module Helper
  # useful methods for Date processing
  module Date
    def new_date_after_today_date?
      new_date > today_date
    end

    def convert_to_format_yyyy_mm__dd(text)
      ::Date._iso8601(text).values.rotate
    end

    def new_date_year_not_today_date_year?
      new_date.year != today_date.year
    end

    def new_date_before_today_date?
      new_date < today_date
    end

    def today_date
      ::Date.today
    end

    def time_left
      (user.semester[:finish] - user.semester[:start]).to_i
    end

    def new_date
      ::Date.new(*::Date._parse(text).values)
    end
  end
end
