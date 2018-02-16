class ReceiveMessage
  def read_message(information, gitik, github)
    case information[:message].text
      when /start/
        ProcessMessage.new.start(information)
      when /set_repo/
        ProcessMessage.new.set_repo_part_of_get_link(information)
        information = gitik.listen(information[:bot]) #Here we get link to rep
        user = ProcessMessage.new.find_user_and_message_create(information[:message].chat.id, "/set_repo\n#{information[:message].text}")
        ProcessMessage.new.set_repo_part_of_set_link(information, github, user)
      when /show_repo/
        user = ProcessMessage.new.find_user_and_message_create(information[:message].chat.id, '/show_repo')
        ProcessMessage.new.show_repo(information, user)
      when /search/
        ProcessMessage.new.search_part_of_get_key(information, github)
        information = gitik.listen(information[:bot])#Here we get keywords
        user = ProcessMessage.new.find_user_and_message_create(information[:message].chat.id, "/search\n#{information[:message].text}")
        ProcessMessage.new.search_part_of_searching(information, github, user)
      when /history/
        user = ProcessMessage.new.find_user_and_message_create(information[:message].chat.id, '/history')
        ProcessMessage.new.history(information, github, user)
      when /help/
        user = ProcessMessage.new.find_user_and_message_create(information[:message].chat.id, '/help')
        ProcessMessage.new.help(information, user)
    end
  end
end
