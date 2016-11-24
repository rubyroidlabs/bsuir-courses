
	def db_get 
		db = SQLite3::Database.new 'world_of_phrases.db'
		db.results_as_hash = true
		return db
	end

	def check_unique_login(login)
		db = db_get
		result = db.execute "SELECT username FROM users WHERE username = '#{login}';"
		if	result.any?
			return false
		else
			return true
		end
	end	

	def check_password(login, password)
		db = db_get
		result = db.execute "SELECT password FROM users WHERE username = '#{login}';"
		result.each do |value|
			if value['password'] == password 
				return true
			else
				return false
			end
		end	
	end	

	def check_and_save(word, continue, username, id)
		if check_word(word)
			save_word_or_phrase(word, continue, username, id)
			return true
		else
			return false
		end
	end

	def check_word(word)
		i = word.scan(".").size
		if i == 0
			return true
		else
			return false
		end
	end	

	def save_word_or_phrase(word, continue, user, id)
		@db = db_get
	    max_id = @db.execute 'SELECT MAX(id) FROM phrases;'
	    p "---------max------------"
		p max_id[0][0].nil?
		p "--------id------------"
		p id
		p "--------------------"
		if !max_id[0][0].nil? && id == 0
			p "!11111111111111"
			max_id = max_id.flatten
			@id = max_id[0][0]
			@id += 1
		elsif id != 0
			@id = id
		elsif max_id[0][0].nil? && id == 0
			@id = 1
		end
		if continue.nil?
			flag = 0
		else 
			flag = 1
		end

		date_time = Time.now.strftime("%Y-%m-%d %H:%M")
		id_user = @db.execute "SELECT id FROM users WHERE username = '#{user}'"
		
		@db.execute 'INSERT INTO phrases (id, word, id_user, date_time, flag)
		    VALUES (?, ?, ?, ?, ?);', [@id, @word, id_user[0][0], date_time.to_s, flag]
	end
