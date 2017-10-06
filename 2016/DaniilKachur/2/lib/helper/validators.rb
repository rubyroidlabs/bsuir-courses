module Helper
  # module contain validation methods
  module Validators
    include Labs
    include Date
    include Buttons

    def valid_date?(date_border)
      yield(new_date) if valid_date_format? && valid_date_border?(date_border) && block_given?
    end

    def valid_date_format?
      !invalid_date_format?
    end

    def valid_date_border?(date_border)
      !invalid_date_border?(date_border)
    end

    def invalid_date_format?
      if ::Date._iso8601(text).empty?
        send_message("Не надо нам вашу дату, у нас есть своя YYYY-MM-DD")
      elsif ::Date.valid_date?(*convert_to_format_yyyy_mm__dd(text)) == false
        send_message("Ты неправильно ввел месяц или день")
      elsif new_date_year_not_today_date_year?
        send_message("Живи в настоящем, #{today_date.year} году")
      else
        false
      end
    end

    def invalid_date_border?(date_border)
      case date_border
      when "start_date"
        new_date_after_today_date? && send_message("Видимо ты потерялся во времени. Семестр уже начался, поэтому введи дату дня из прошлого.")
      when "finish_date"
        new_date_before_today_date? && send_message("Видимо ты потерялся во времени. Конец семестра еще впереди, поэтому введи дату дня из будущего.")
      else
        false
      end
    end

    def valid_labs?
      if (text =~ /\A[0-1]?[0-5]\z/).nil?
        send_message("Есть конечно разные преподы, но иметь больше 15 лаб вряд ли возможно.")
      else
        block_given? && yield(new_labs)
      end
    end

    def valid_subject?
      if text.length > 20
        send_message("В названии предмета вряд ли когда-нибудь будет больше 20 символов")
      else
        block_given? && yield
      end
    end

    def subject_button_pressed?
      if text_from_button.nil?
        send_message("Нажмите на кнопку из сообщения выше.")
      elsif not_passed_labs.empty?
        send_message(labs_complete)
      else
        block_given? && yield
      end
    end

    def lab_button_pressed?
      if text_from_button.nil?
        send_message("Нажмите на кнопку из сообщения выше.")
      else
        block_given? && yield
      end
    end
  end
end
