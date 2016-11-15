module Helper
  # useful methods for labs pocessing
  module Labs
    def valid_labs?
      if (text =~ /\A[0-9]?[0-9]\z/).nil?
        send_message("Ваши лабы уже с ушей свисают, а правдой даже не пахнет (введите число < 100)")
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
      old_labs[text.to_i] = "passed"
      old_labs
    end

    def passed_labs
      old_labs.each_index.select { |i| old_labs[i] == "passed" }
    end

    def not_passed_labs
      old_labs.each_index.select { |i| old_labs[i] == "not passed" }
    end

    def accepted_labs(labs_amount)
      "#{(labs_amount * days_ratio).to_i} из #{labs_amount}"
    end
  end
end
