# frozen_string_literal: true

require_relative 'message_responder'

class SetRepoResponder < MessageResponder
  def respond
    repo = message.text.split(' ')[1]

    if repo.nil?
      answer_with_message('Репозиторий не был указан. Может быть /help?')
    else
      update_repo(repo)
      answer_with_message("Репозиторий #{repo} установлен")
    end
  end

  private

  def update_repo(repo)
    @user.update(current_repo_url: repo)
  end
end
