require 'octokit'
require_relative 'TeleBotCommand'
# safe repository setter
class RepoCommandExtension < TeleBotCommand
  def initialize_repo(address = String.new)
    begin
      @repo = Octokit.repo(address)
    rescue Octokit::NotFound
      'Cannot find this repository.'
    rescue Octokit::RepositoryUnavailable
      'Access denied.'
    rescue Octokit::InvalidRepository
      'Invalid repository.'
    rescue
      'Unknown error.'
    end
  end
end
