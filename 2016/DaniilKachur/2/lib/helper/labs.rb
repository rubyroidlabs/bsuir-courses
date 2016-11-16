module Helper
  # useful methods for labs pocessing
  module Labs
    def valid_labs?
      if (text =~ /\A[0-1]?[0-5]\z/).nil?
        send_message("Есть конечно разные преподы, но иметь больше 15 лаб вряд ли возможно.")
      else
        yield(new_labs)
      end
    end

    def new_labs
      Array.new(text.to_i) { "not passed" }
    end

    def old_labs
      labs = user.subjects[text] || user.subjects[user.next_bot_command[:data][:subject]]
      labs.nil? ? [] : labs
    end

    def update_labs
      old_labs[text.to_i - 1] = "passed"
      old_labs
    end

    def not_passed_labs(labs = old_labs)
      indexes = labs.each_index.map { |i| i + 1 }
      indexes.select { |i| labs[i - 1] == "not passed" }
    end

    def accepted_labs(labs_amount)
      "#{(labs_amount * days_ratio).to_i} из #{labs_amount}"
    end

    def labs_complete
      user.reset_next_bot_command
      "Все лабы сдал, красава!\n"
    end
  end
end
