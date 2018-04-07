# frozen_string_literal: true

require 'octokit'

class GitHubService
  def initialize(repo:, query:)
    @repo = repo
    @query = query
  end

  def commits
    Octokit.search_commits("#{@query}+repo:#{chomp_repo}")[:items]
  rescue Octokit::UnprocessableEntity => e
    puts "[Octokit Repo] Exeption <wrong repository>: #{e.backtrace.inspect}"
    nil
  end

  private

  def chomp_repo
    Octokit::Repository.from_url(@repo)
  end
end
