require_relative 'base'
require 'octokit'

class Search < Base
  def get_repo
    url_repo = File.open("./chat_ids/#{@user_id}") {|f| f.readline}
    url_repo.gsub(/http(s)?:\/\/github.com\//, '')
  end

  def add_history(query)
    File.open("./chat_ids/#{@user_id}_history", 'a') { |f|
      f.puts query
    }
  end

  def commits(query)
    client = Octokit::Client.new(:login => 'YuliyaBond', :password => 'Sharik1109')
    repo = get_repo
    if repo.nil?
      telegram_send_message("Your don't set repo!")
    else
      commits = client.search_commits("repo:#{repo} #{query}", {page: 1, per_page: 10})
      add_history(query)
      total_count = commits[:total_count]
      commits_all = []
      commits[:items].each_with_index do |commit, index|
        commits_all << "#{index}. #{commit[:commit][:message].gsub("\n", ' ')} -> [Link to commit](#{commit[:commit][:url]})"
      end

      telegram_send_message(commits_all.join("\n"))
      telegram_send_message("*Results #{commits_all.size} from #{total_count}*")
    end
  end
end
