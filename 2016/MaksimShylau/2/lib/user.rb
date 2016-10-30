class User
	def initialize(id)
		@id = id
		@status = nil
	end

	def check_status(status, id, hash, redis, command, message, subject_count)
		case status
		  when "wanna_sem_start"
		    if !DateParser.is_correct?(message.text)
		      command.send_message("*Некорректный ввод*. Повтори")
		      return true
		    end
		    hash["user_status"] = "wanna_sem_end"
		    hash["sem_start"] = message.text
		    command.send_message("Окей, дату начала ты указал: _#{message.text}_, теперь укажи дату окончания. \nНапример, *31.12.2016*")
		    redis.set(id, hash.to_json)
		    return true
		  when "wanna_sem_end"
		    if !DateParser.is_correct?(message.text)
		      command.send_message("*Некорректный ввод*. Повтори")
		      return true
		    end
		    hash["user_status"] = nil
	      hash["sem_end"] = message.text
	      command.send_message("Отлично, семестр заканчивается _#{message.text}_ :) ")
	      redis.set(id, hash.to_json)
	      start_parse = DateParser.new(hash["sem_start"])
	      end_parse = DateParser.new(hash["sem_end"])
	      command.send_message(DateParser.difference(end_parse, start_parse))
        return true
	    when "wanna_subject"
	      subject_count += 1
	      hash["subject_count"] = subject_count
	      hash["subject"][subject_count-1]={}
	      hash["subject"][subject_count-1]["subject_name"] = message.text
	      command.send_message("Название предмета — *#{message.text}*")
	      command.send_message(HOW_MANY_LABS)
	      hash["user_status"] = "wanns_labs_count"
	      redis.set(id, hash.to_json)
	      return true
	    when "wanns_labs_count"
	      if !DateParser.is_correct_count?(message.text)
	      	command.send_message("*Некорректный ввод*. Попробуй ещё раз")
	        return true
	      end
	      hash["subject"][subject_count-1]["labs_count"] = message.text
	      command.send_message("Количество лаб — *#{message.text}*")
	      hash["user_status"] = nil
	      redis.set(id, hash.to_json)
	      return true
	      else 
	    	return false
		end
	end

	attr_accessor :id
	attr_accessor :status
end
