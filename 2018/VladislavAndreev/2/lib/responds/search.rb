# frozen_string_literal: true

require_relative 'message_sender'
require_relative '../github/gh_service'

class SearchResponder < MessageResponder
  def respond
    search_query = message.text.split(' ')[1]

    if search_query.nil?
      answer_with_message('Текст для поиска не был указан. Может быть /help?')
    else
      commits = GitHubService.new(repo: repo, query: search_query).commits

      if commits.nil?
        answer_with_message('Указанного репозитория не существует 😢')
      else
        save_request(search_query)

        answer_with_message('Вот последние несколько коммитов по запросу:')

        commits.take(5).each do |commit|
          send_commit_info(*get_commit_info(commit))
        end
      end
    end
  end

  private

  def send_commit_info(c_url, c_author, c_message)
    answer_with_message(
      <<-COMMIT_INFO
      🔗 *Адрес коммита*: #{c_url}
      \n🚻 *Автор коммита*: #{c_author}
      \n📃 *Полный текст сообщения*:
      ```\n#{c_message}```
      COMMIT_INFO
    )
  end

  def get_commit_info(commit)
    c_url = commit[:url]
    c_message = commit[:commit][:message]

    c_author = if commit[:author].nil?
                 "#{commit[:commit][:author][:name]}, \
                 #{commit[:commit][:author][:email]}"
               else
                 commit[:author][:login]
               end

    [c_url, c_author, c_message]
  end

  def repo
    @user.current_repo_url
  end

  def save_request(search_request)
    SearchRequest.create(user_id: @user.id,
                         query_text: search_request)
  end
end
