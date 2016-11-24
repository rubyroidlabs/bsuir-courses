def db_get 
  db = SQLite3::Database.new 'world_of_phrases.db'
  db.results_as_hash = true
  return db
end

def check_unique_login(login)
  db = db_get
  result = db.execute "SELECT username FROM users WHERE username = '#{login}';"
  if result.any?
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
  if i.zero?
    return true
  else
    return false
  end
end	

def get_id_phrase(id_phrase, max_id)
  if !max_id[0][0].nil? && id_phrase.zero?
    max_id = max_id.flatten
    id = max_id[0][0]
    id += 1
  elsif id_phrase.nonzero?
    id = id_phrase
  elsif max_id[0][0].nil? && id_phrase.zero?
    id = 1
  end
  return id
end

def get_flag(continue)
  if continue.nil?
    flag = 0
  else flag = 1
  end
  return flag
end

def save_word_or_phrase(word, continue, user, id)
  @db = db_get
  max_id = @db.execute "SELECT MAX(id) FROM phrases;"
  @id = get_id_phrase(id, max_id)
  flag = get_flag(continue)
  date_time = Time.now.strftime("%Y-%m-%d %H:%M")
  id_user = @db.execute "SELECT id FROM users WHERE username = '#{user}'"
  @db.execute "INSERT INTO phrases (id, word, id_user, date_time, flag) VALUES (?, ?, ?, ?, ?);", [@id, word, id_user[0][0], date_time.to_s, flag]
end
