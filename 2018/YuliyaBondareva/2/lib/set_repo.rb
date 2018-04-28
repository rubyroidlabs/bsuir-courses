require_relative 'base'
class SetRepo < Base
  def save_repo(repo)
    File.write("./chat_ids/#{@user_id}", repo)
    telegram_send_message("We saved your repo: #{repo}")
  end
end
