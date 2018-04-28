# frozen_string_literal: true

require_relative 'message_responder'

class ShowRepoResponder < MessageResponder
  def respond
    answer_with_message("Текущий репозиторий: #{repo}")
  end

  private

  def repo
    @user.current_repo_url
  end
end
