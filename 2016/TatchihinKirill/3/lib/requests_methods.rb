<<<<<<< HEAD
#check
=======
#tabs
>>>>>>> b3108cfd7b3008f91f997aaffd2e350147258bc0
module RequestsMethods
	DELAY = 30
	def output_all_phrases(redis)
		output = []
		temp = {}	
		if redis.get("phrases") != nil
			temp =JSON.parse($redis.get("phrases"))
		end
		temp.each_value{|v| output.push(v)}
		output
	end
	def add_new_phrase(redis, word)
		temp = redis.get("phrases")
		word = params.fetch("word1")
		word = make_input_phrase_to_word(word)
		if temp != nil
			temp = JSON.parse(temp)
			temp[word] = [word, session[:user_name]]
		else
			temp = {}
			temp[word] = [word, session[:user_name]]
		end
		temp = temp.to_json
		redis.set("phrases", temp)
	end
	def redact_phrase(redis, word, last_redact )
		new_word = params.fetch("phrase")
		word = make_starter_word(word)
		temp = JSON.parse($redis.get("phrases"))
    old_phrase = temp.key(word)
    temp[word][0] = temp[word][0] + " " + new_word
		temp[word][1] = session[:user_name]
		temp = temp.to_json
    redis.set("phrases", temp)
	end
	def make_timer
	  return Time.now + DELAY
	end
	def make_input_phrase_to_word(phrase)
		if ((phrase.include?(" ")) && (phrase.index(" ") >= 1))
			return phrase[0...phrase.index(" ")]
		end
		return phrase
	end
	def make_starter_word(phrase)
		if phrase.include?(" ")
			return phrase = phrase[0...phrase.index(" ")]
		else
			return phrase
		end
	end
end
