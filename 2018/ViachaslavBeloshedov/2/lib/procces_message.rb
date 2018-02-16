class ProcessMessage
#We store all information in a hash 'information' I think it very convenient because we can get data. information has got :bot and :message
  def find_user_and_message_create(id, message)
    user = User.find_by(user_id: id)
    user.messages.create(message: message)
    user
  end

  def start(information)
    User.find_or_create_by(user_id: information[:message].chat.id).messages.create(message:'/start') #I dont use find_user_and_message_create because of "find_or_create_by" It can be first message from user
    SendMessage.new.send(information, "Привет, #{information[:message].from.first_name}")
  end

  def set_repo_part_of_get_link(information)
    SendMessage.new.send(information, "Предоставь ссылку на репозиторий")
  end

  def set_repo_part_of_set_link(information, github, user)
    split_url = information[:message].text.split('/')
    if (information[:message].text[/github.com/] && split_url.size == 5)
      begin
      github.repos.get split_url[3], split_url[4]
      rescue Github::Error::NotFound
        SendMessage.new.send(information, "Доступа к данному репозиторию нет")
      else
        SendMessage.new.send(information, "Доступ есть.Подключаемся!")
        user.update(current_repo:information[:message].text)
      end
    else
      SendMessage.new.send(information, "Проверьте введенные данные")
    end
  end

  def show_repo(information, user)
    if user.current_repo[/github.com/]
      SendMessage.new.send(information, "Сейчас мы подключены к следующему репозиторию: #{user.current_repo}")
    else
      SendMessage.new.send(information, "Подключение к какому-либо репозиторию отсуствует!")
    end
  end

  def search_part_of_get_key(information, github)
    SendMessage.new.send(information, "Что будем искать?")
  end

  def search_part_of_searching(information,  github, user)
    unless user.current_repo[/github.com/]
      SendMessage.new.send(information,"Репозиторий не подключен")
      return
    end
    how_many_commits_is_valid = 0
    split_url = user.current_repo.split('/')
    what_search = information[:message].text
    github.repos.commits.all split_url[3], split_url[4], per_page:100 do |commit|#We will get all commits from repo
      if commit[:commit][:message][what_search
        how_many_commits_is_valid += 1
        SendMessage.new.send(information,"Найдено совпадение\nСсылка на коммит:#{commit[:html_url]}")
      end
    end
    SendMessage.new.send(information, "Всего найдено #{how_many_commits_is_valid} коммитов")
  end

  def history(information, github, user)
    history_messages =''
    user.messages.each do |mess|
      history_messages = history_messages + mess.message + "\n"
     end
     SendMessage.new.send(information, "История запросов:\n#{history_messages}")
  end

  def help(information, user)
    SendMessage.new.send(information, "Я могу выполнить следующие действия:\n/start-поздороваться\n/set_repo-запросить ссылку на репозиторий" +
      "\n/show_repo-показать текущий репозиторий\n/history-история запросов\n/search-поиск ключевого слова в репозитории\n/help-помощь")
  end

end
