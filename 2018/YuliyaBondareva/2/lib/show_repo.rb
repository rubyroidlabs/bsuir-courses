require_relative 'base'
class ShowRepo < Base
  def get_repo
    repo = File.open("./chat_ids/#{@user_id}") {|f| f.readline}
    telegram_send_message("Your repo: #{repo}")
  end
end